
class UBTService_FindNearestPlayer : UBTService_BlueprintBase
{
	private UBlackboardKeyType_Object ObjectObject = Cast<UBlackboardKeyType_Object>(NewObject(Class.DefaultObject, UBlackboardKeyType_Object, n"ObjectType"));
	private UBlackboardKeyType_Bool BoolType = Cast<UBlackboardKeyType_Bool>(NewObject(Class.DefaultObject, UBlackboardKeyType_Bool, n"BoolType"));

	UPROPERTY()
	FBlackboardKeySelector TargetToFollow;
	default TargetToFollow.AllowedTypes.Add(ObjectObject);

	UPROPERTY()
	FBlackboardKeySelector IsHitReacting;
	default IsHitReacting.AllowedTypes.Add(BoolType);

	UFUNCTION(BlueprintOverride)
	void TickAI(AAIController OwnerController, APawn ControlledPawn, float DeltaSeconds)
	{
		Print(f"{ControlledPawn.GetName()} is TickAI");

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
		AActor NearestPlayer = nullptr;

		if (Players.Num() == 1) {
			NearestPlayer = Players[0];
		} else {
			float NearestDistance = 10000;
			NearestPlayer = Players[0];
			for (int i = 1; i < Players.Num(); i++) {
				float Distance = Players[i].GetActorLocation().Distance(NearestPlayer.GetActorLocation());
				if (Distance < NearestDistance) {
					NearestDistance = Distance;
					NearestPlayer = Players[i];
				}
			}
		}

		// AIHelper::SimpleMoveToActor(OwnerController, NearestPlayer);
		AIHelper::GetBlackboard(OwnerController).SetValueAsObject(TargetToFollow.SelectedKeyName, NearestPlayer);
	}
}