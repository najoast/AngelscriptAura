
// This class provides mouse click movement function.
class UClickToMove : UObject
{
	AAuraPlayerController OwnerController;

	// Movement Variables
	const float ShortPressThreshold = 0.5;
	const float AutoRunAcceptanceRadius = 50;

	private FVector CachedDestination = FVector::ZeroVector;
	private float MouseHeldTime = 0;
	private bool bAutoRunning = false;

	// Functions
	void Ctor(AAuraPlayerController InOwnerController)
	{
		OwnerController = InOwnerController;
	}

	void StopAutoRun()
	{
		bAutoRunning = false;
	}

	void ClickPressed()
	{
		bAutoRunning = false;
	}

	void ClickHeld()
	{
		if (OwnerController.IsTargeting()) {
			return;
		}

		MouseHeldTime += GetWorld().GetDeltaSeconds();

		if (OwnerController.HitResult.bBlockingHit) {
			CachedDestination = OwnerController.HitResult.ImpactPoint;
		}

		APawn ControlledPawn = OwnerController.GetControlledPawn();
		if (ControlledPawn != nullptr) {
			const FVector WorldDirection = (CachedDestination - ControlledPawn.GetActorLocation()).GetSafeNormal();
			ControlledPawn.AddMovementInput(WorldDirection);
		}
	}

	void ClickReleased()
	{
		float ThisHeldTime = MouseHeldTime;
		MouseHeldTime = 0.f;

		if (OwnerController.IsTargeting()) {
			return;
		}
		if (ThisHeldTime <= ShortPressThreshold) {
			StartAutoRun();
		}
	}

	void StartAutoRun() {
		APawn ControlledPawn = OwnerController.GetControlledPawn();
		if (ControlledPawn == nullptr) {
			return;
		}
		FVector PathStart = ControlledPawn.GetActorLocation();
		UNavigationPath NavPath = UNavigationSystemV1::FindPathToLocationSynchronously(PathStart, CachedDestination, ControlledPawn);
		if (NavPath != nullptr && NavPath.PathPoints.Num() > 0) {
			USplineComponent MovementSpline = OwnerController.MovementSpline;
			MovementSpline.ClearSplinePoints();
			for (FVector Point : NavPath.PathPoints) {
				MovementSpline.AddSplinePoint(Point, ESplineCoordinateSpace::World);
				System::DrawDebugSphere(Point, 8, 12, FLinearColor::Purple, 30);
			}
			CachedDestination = NavPath.PathPoints[NavPath.PathPoints.Num() - 1];
			bAutoRunning = true;
		}
	}

	void Tick()
	{
		if (!bAutoRunning) {
			return;
		}
		APawn ControlledPawn = OwnerController.GetControlledPawn();
		if (!System::IsValid(ControlledPawn)) {
			return;
		}

		USplineComponent MovementSpline = OwnerController.MovementSpline;
		const FVector LocationOnSpline = MovementSpline.FindLocationClosestToWorldLocation(ControlledPawn.GetActorLocation(), ESplineCoordinateSpace::World);
		const FVector Direction = MovementSpline.FindDirectionClosestToWorldLocation(LocationOnSpline, ESplineCoordinateSpace::World);
		ControlledPawn.AddMovementInput(Direction);

		const float DistanceToDestination = (LocationOnSpline - CachedDestination).Size();
		if (DistanceToDestination <= AutoRunAcceptanceRadius) {
			bAutoRunning = false;
		}
	}

	// 只有在点鼠标左键且不能放火球时（普攻）才接管输入，从而实现“点击移动”
	bool NeedTakeOverInput(FGameplayTag InputTag) {
		if (InputTag == GameplayTags::Input_LMB && !OwnerController.CanCastFireBolt()) {
			return true;
		}
		StopAutoRun();
		return false;
	}
}
