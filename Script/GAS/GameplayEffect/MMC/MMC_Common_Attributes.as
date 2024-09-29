
// Min Attack Power = Attack Power * 0.9
class UMMC_Common_MinAttackPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition AttackPowerCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"AttackPower", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute AttackPowerAttribute;

	default RelevantAttributesToCapture.Add(AttackPowerCaptureDefinition);
	default AttackPowerAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"AttackPower");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 AttackPower = GetCapturedAttributeMagnitude(Spec, AttackPowerAttribute, SourceTags, TargetTags);
		return AttackPower * 0.9;
	}
}

// Max Attack Power = Attack Power * 1.1
class UMMC_Common_MaxAttackPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition AttackPowerCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"AttackPower", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute AttackPowerAttribute;

	default RelevantAttributesToCapture.Add(AttackPowerCaptureDefinition);
	default AttackPowerAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"AttackPower");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 AttackPower = GetCapturedAttributeMagnitude(Spec, AttackPowerAttribute, SourceTags, TargetTags);
		return AttackPower * 1.1;
	}
}

// Min Magic Power = Magic Power * 0.9
class UMMC_Common_MinMagicPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition MagicPowerCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"MagicPower", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute MagicPowerAttribute;

	default RelevantAttributesToCapture.Add(MagicPowerCaptureDefinition);
	default MagicPowerAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"MagicPower");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 MagicPower = GetCapturedAttributeMagnitude(Spec, MagicPowerAttribute, SourceTags, TargetTags);
		return MagicPower * 0.9;
	}
}

// Max Magic Power = Magic Power * 1.1
class UMMC_Common_MaxMagicPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition MagicPowerCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"MagicPower", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute MagicPowerAttribute;

	default RelevantAttributesToCapture.Add(MagicPowerCaptureDefinition);
	default MagicPowerAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"MagicPower");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 MagicPower = GetCapturedAttributeMagnitude(Spec, MagicPowerAttribute, SourceTags, TargetTags);
		return MagicPower * 1.1;
	}
}
