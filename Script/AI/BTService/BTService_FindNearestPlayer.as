
class UBTService_FindNearestPlayer : UBTService_BlueprintBase
{
	UFUNCTION(BlueprintOverride)
	void TickAI(AAIController OwnerController, APawn ControlledPawn, float DeltaSeconds)
	{
		Print(f"{ControlledPawn.GetName()} is TickAI");
		// GetAllActorsOfClassWithTag(AuraConst::PlayerTag);

		if (ControlledPawn.ActorHasTag(AuraConst::PlayerTag)) {
			Print("Player does not need to find a player");
			return;
		}

		TArray<AActor> Players;
		Gameplay::GetAllActorsWithTag(AuraConst::PlayerTag, Players);

		if (Players.Num() == 0) {
			Print("No player found");
			return;
		}

		// Find the nearest player
		float NearestDistance = 10000;
		AActor NearestPlayer = Players[0];
		for (int i = 1; i < Players.Num(); i++) {
			float Distance = Players[i].GetActorLocation().Distance(NearestPlayer.GetActorLocation());
			if (Distance < NearestDistance) {
				NearestDistance = Distance;
				NearestPlayer = Players[i];
			}
		}

		AIHelper::SimpleMoveToActor(OwnerController, NearestPlayer);
	}
}