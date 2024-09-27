
class UEQC_Player : UEnvQueryContext_BlueprintBase
{
	UFUNCTION(BlueprintOverride)
	void ProvideActorsSet(UObject QuerierObject, AActor QuerierActor, TArray<AActor>& ResultingActorsSet) const
	{
		Gameplay::GetAllActorsWithTag(AuraConst::PlayerTag, ResultingActorsSet);
		GetAllActorsOfClass
	}
}
