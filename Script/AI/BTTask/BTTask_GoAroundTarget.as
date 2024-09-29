
class UBTTask_GoAroundTarget : UBTTask_BlueprintBase {
	UPROPERTY()
	FBlackboardKeySelector AroundTarget;
	private UBlackboardKeyType_Vector VectorObject = Cast<UBlackboardKeyType_Vector>(NewObject(Class.DefaultObject, UBlackboardKeyType_Vector, n"VectorType"));
	default AroundTarget.AllowedTypes.Add(VectorObject);

	UFUNCTION(BlueprintOverride)
	void ExecuteAI(AAIController OwnerController, APawn ControlledPawn) {
		FinishExecute(ExecuteImpl(OwnerController, ControlledPawn));
	}

	private bool ExecuteImpl(AAIController OwnerController, APawn ControlledPawn) {
		UBlackboardComponent BlackboardComponent = AIHelper::GetBlackboard(OwnerController);
		AActor Target = Cast<AActor>(BlackboardComponent.GetValueAsObject(AuraConst::AI_Blackboard_Key_TargetToFollow));
		if (Target == nullptr) {
			return false;
		}

		FVector RandomLocation;
		if (!UNavigationSystemV1::GetRandomLocationInNavigableRadius(Target.GetActorLocation(), RandomLocation, 300)) {
			return false;
		}

		BlackboardComponent.SetValueAsVector(AroundTarget.SelectedKeyName, RandomLocation);
		// AIHelper::SimpleMoveToLocation(OwnerController, RandomLocation);
		System::DrawDebugSphere(RandomLocation, 10, 12, FLinearColor::DPink, 0.5);
		return true;
	}
}
