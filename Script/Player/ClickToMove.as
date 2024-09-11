
// This class provides mouse click movement function.
class UClickToMove : UObject
{
	AAuraPlayerController OwnerController;

	// Movement Variables
	const float ShortPressThreshold = 0.5;
	const float AutoRunAcceptanceRadius = 50;

	FVector CachedDestination = FVector::ZeroVector;
	float FollowTime = 0;
	bool bAutoRunning = false;
	bool bTargeting = false;

	// Functions
	void Ctor(AAuraPlayerController InOwnerController)
	{
		OwnerController = InOwnerController;
	}

	void ClickPressed()
	{
		bTargeting = OwnerController.ThisEnemy != nullptr;
		bAutoRunning = false;
	}

	void ClickHeld()
	{
		if (bTargeting) {
			return;
		}

		FollowTime += GetWorld().GetDeltaSeconds();

		FHitResult HitResult;
		if (OwnerController.GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, HitResult)) {
			CachedDestination = HitResult.ImpactPoint;
		}

		APawn ControlledPawn = OwnerController.GetControlledPawn();
		if (ControlledPawn != nullptr) {
			const FVector WorldDirection = (CachedDestination - ControlledPawn.GetActorLocation()).GetSafeNormal();
			ControlledPawn.AddMovementInput(WorldDirection);
		}
	}

	void ClickReleased()
	{
		if (bTargeting) {
			return;
		}
		APawn ControlledPawn = OwnerController.GetControlledPawn();
		if (ControlledPawn == nullptr) {
			return;
		}
		if (FollowTime > ShortPressThreshold) {
			return;
		}

		FVector PathStart = ControlledPawn.GetActorLocation();
		UNavigationPath NavPath = UNavigationSystemV1::FindPathToLocationSynchronously(PathStart, CachedDestination, ControlledPawn);
		if (NavPath != nullptr && NavPath.PathPoints.Num() > 0) {
			USplineComponent MovementSpline = OwnerController.MovementSpline;
			MovementSpline.ClearSplinePoints();
			for (FVector Point : NavPath.PathPoints) {
				MovementSpline.AddSplinePoint(Point, ESplineCoordinateSpace::World);
				// System::DrawDebugSphere(Point, 8.f, 8, FColor::Green, 0, 5.f);
				System::DrawDebugSphere(Point, 8, 12, FLinearColor::Purple, 30);
			}
			CachedDestination = NavPath.PathPoints[NavPath.PathPoints.Num() - 1];
			bAutoRunning = true;
		}

		FollowTime = 0.f;
		bTargeting = false;
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
}
