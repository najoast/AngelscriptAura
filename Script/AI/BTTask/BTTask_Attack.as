
class UBTTask_Attack : UBTTask_BlueprintBase
{
	default NodeName = "TestAttack";

	UFUNCTION(BlueprintOverride)
	void ExecuteAI(AAIController OwnerController, APawn ControlledPawn)
	{
		FinishExecute(ExectueImpl(OwnerController, ControlledPawn));
	}

	bool ExectueImpl(AAIController OwnerController, APawn ControlledPawn)
	{
		UAbilitySystemComponent ASC = AbilitySystem::GetAbilitySystemComponent(ControlledPawn);
		if (ASC == nullptr) {
			return false;
		}

		FGameplayTagContainer TagContainer;
		TagContainer.AddTag(GameplayTags::Abilities_Attack);
		return ASC.TryActivateAbilitiesByTag(TagContainer);
	}

	// bool Selector() {
	// 	TArray<int> Nodes;
	// 	for (int node : Nodes) {
	// 		if (node.IsSucceed()) {
	// 			return true;
	// 		}
	// 	}
	// 	return false;
	// }

	// bool Sequence() {
	// 	TArray<int> Nodes;
	// 	for (int node : Nodes) {
	// 		if (!node.IsSucceed()) {
	// 			return false;
	// 		}
	// 	}
	// 	return true;
	// }
}
