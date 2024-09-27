
class UABTT_Attack : UBTTask_BlueprintBase
{
	default NodeName = "TestAttack";

	UFUNCTION(BlueprintOverride)
	void ExecuteAI(AAIController OwnerController, APawn ControlledPawn)
	{
		Print(f"ExecuteAI: {OwnerController =}");
		System::DrawDebugSphere(ControlledPawn.GetActorLocation(), 100, 12, FLinearColor::Red, 0.5);
		this.FinishExecute(true);
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
