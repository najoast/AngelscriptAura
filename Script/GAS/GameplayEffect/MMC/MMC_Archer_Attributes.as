/*
Max Health = Vitality * 15
Max Mana = Intelligence * 10
Health Regen = Vitality * 0.3
Mana Regen = Intelligence * 0.2
Attack Power = Dexterity * 2 + Strength * 0.5
Magic Power = Intelligence * 2
Defense = Strength * 0.5 + Vitality * 1
Accuracy = 0.6 + (Dexterity / 150)
Evasion = 0.3 + (Dexterity / 150)
Critical Chance = 0.05 + (Dexterity / 300) * 0.25
Critical Damage = 120% + (Min(Dexterity,200) / 200) * 80%
Magic Resistance = Intelligence * 1
*/

// MaxHealth = Vitality * 15
class UMMC_Archer_MaxHealth : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Vitality * 15;
	}
}

// MaxMana = Intelligence * 10
class UMMC_Archer_MaxMana : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 10;
	}
}

// Health Regen = Vitality * 0.3
class UMMC_Archer_HealthRegen : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Vitality * 0.3;
	}
}

// Mana Regen = Intelligence * 0.2
class UMMC_Archer_ManaRegen : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 0.2;
	}
}

// Attack Power = Dexterity * 2 + Strength * 0.5
class UMMC_Archer_AttackPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition StrengthCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;
	FGameplayAttribute StrengthAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default RelevantAttributesToCapture.Add(StrengthCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");
	default StrengthAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		float32 Strength = GetCapturedAttributeMagnitude(Spec, StrengthAttribute, SourceTags, TargetTags);
		return Dexterity * 2 + Strength * 0.5;
	}
}

// Magic Power = Intelligence * 2
class UMMC_Archer_MagicPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 2;
	}
}

// Defense = Strength * 0.5 + Vitality * 1
class UMMC_Archer_Defense : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition StrengthCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute StrengthAttribute;
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(StrengthCaptureDefinition);
	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default StrengthAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength");
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Strength = GetCapturedAttributeMagnitude(Spec, StrengthAttribute, SourceTags, TargetTags);
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Strength * 0.5 + Vitality * 1;
	}
}

// Accuracy = 0.6 + (Dexterity / 150)
class UMMC_Archer_Accuracy : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.6 + (Dexterity / 150);
	}
}

// Evasion = 0.3 + (Dexterity / 150)
class UMMC_Archer_Evasion : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.3 + (Dexterity / 150);
	}
}

// Critical Chance = 0.05 + (Dexterity / 300) * 0.25
class UMMC_Archer_CriticalChance : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.05 + (Dexterity / 300) * 0.25;
	}
}

// Critical Damage = 120% + (Min(Dexterity,200) / 200) * 80%
class UMMC_Archer_CriticalDamage : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return float32(1.2 + (Math::Min(Dexterity,200) / 200) * 0.8);
	}
}

// Magic Resistance = Intelligence * 1
class UMMC_Archer_MagicResistance : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 1;
	}
}
