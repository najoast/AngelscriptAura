
class UMMC_MaxHealth : UAngelscriptModMagnitudeCalculation
{
	FGameplayAttribute VigorAttribute;
	FGameplayEffectAttributeCaptureDefinition VigorCaptureDefinition;

	UMMC_MaxHealth()
	{
		VigorAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vigor");

		VigorCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(
			UAuraAttributeSet::StaticClass(), n"Vigor", 
			EGameplayEffectAttributeCaptureSource::Target, false);


		// 这里加不了，因为 RelevantAttributesToCapture 导出时有 BlueprintReadOnly，
		// 所以脚本里加不了，只能在 C++ 里才能 Add。
		// 结论：在 Angelscript 里没法写 MMC 的派生类。
		// 解决方案：在 C++ 里派生 UGameplayModMagnitudeCalculation，实现一个 Add 接口，然后 AS 从这个类派生。
		//          class name: UAngelscriptMMC

		AddRelevantAttributeToCapture(VigorCaptureDefinition);
	}

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;

		float32 VigorValue = GetCapturedAttributeMagnitude(Spec, VigorAttribute, SourceTags, TargetTags);
		return VigorValue * 10 + 77;
	}
}