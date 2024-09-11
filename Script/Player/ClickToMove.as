
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

	UPROPERTY(DefaultComponent)
	USplineComponent MovementSpline;

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
	}
}
