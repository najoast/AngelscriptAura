
// Temp use UGameplayModMagnitudeCalculation instead of UAngelscriptModMagnitudeCalculation for compatibility

// class UMMC_MaxHealth : UAngelscriptModMagnitudeCalculation
class UMMC_MaxHealth : UGameplayModMagnitudeCalculation {
	FGameplayAttribute VigorAttribute;
	FGameplayEffectAttributeCaptureDefinition VigorCaptureDefinition;

	UMMC_MaxHealth() {
		VigorAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vigor");

		VigorCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(
			UAuraAttributeSet::StaticClass(), n"Vigor", 
			EGameplayEffectAttributeCaptureSource::Target, false);


		// AddRelevantAttributeToCapture(VigorCaptureDefinition);
	}

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		return 177;
		// FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		// FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		// float32 VigorValue = GetCapturedAttributeMagnitude(Spec, VigorAttribute, SourceTags, TargetTags);
		// return VigorValue * 10 + 77;
	}
}