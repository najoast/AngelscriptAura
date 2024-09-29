
class UEQC_Player : UEnvQueryContext_BlueprintBase
{
	UFUNCTION(BlueprintOverride)
	void ProvideActorsSet(UObject QuerierObject, AActor QuerierActor, TArray<AActor>& ResultingActorsSet) const {
		// 这里避坑, Gameplay 命名空间里的同名函数，在 PIE 里执行时会报没有 WorldContext 的错误，改用全局命名空间里的函数就没这问题了
		// Gameplay::GetAllActorsWithTag(AuraConst::PlayerTag, ResultingActorsSet);
		// Gameplay::GetAllActorsOfClass(AAuraCharacter, ResultingActorsSet);
		GetAllActorsOfClass(AAuraCharacter, ResultingActorsSet);
	}
}
