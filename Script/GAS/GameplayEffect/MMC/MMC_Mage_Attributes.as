/*
HP = Vitality * 10
MP = Intelligence * 20
Health Regen = Vitality * 0.2
Mana Regen = Intelligence * 0.5
Attack Power = Intelligence * 2 + Dexterity * 0.5
Magic Power = Intelligence * 3
Defense = Strength * 0.5 + Vitality * 0.5
Accuracy = 0.4 + (Dexterity / 250)
Evasion = 0.1 + (Dexterity / 250)
Critical Chance = 0.05 + (Dexterity / 500) * 0.25
Critical Damage = 120% + (Min(Dexterity,100) / 100) * 80%
Magic Resistance = Intelligence * 1.5
*/

// Max Health = Vitality * 10
class UMMC_Mage_MaxHealth : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Vitality * 10;
	}
}

// Max Mana = Intelligence * 20
class UMMC_Mage_MaxMana : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 20;
	}
}

// Health Regen = Vitality * 0.2
class UMMC_Mage_HealthRegen : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Vitality * 0.2;
	}
}

// Mana Regen = Intelligence * 0.5
class UMMC_Mage_ManaRegen : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 0.5;
	}
}

// Attack Power = Intelligence * 2 + Dexterity * 0.5
class UMMC_Mage_AttackPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return Intelligence * 2 + Dexterity * 0.5;
	}
}

// Magic Power = Intelligence * 3
class UMMC_Mage_MagicPower : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 3;
	}
}

// Defense = Strength * 0.5 + Vitality * 0.5
class UMMC_Mage_Defense : UGameplayModMagnitudeCalculation {
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
		return Strength * 0.5 + Vitality * 0.5;
	}
}

// Accuracy = 0.4 + (Dexterity / 250)
class UMMC_Mage_Accuracy : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.4 + (Dexterity / 250);
	}
}

// Evasion = 0.1 + (Dexterity / 250)
class UMMC_Mage_Evasion : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.1 + (Dexterity / 250);
	}
}

// Critical Chance = 0.05 + (Dexterity / 500) * 0.25
class UMMC_Mage_CriticalChance : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.05 + (Dexterity / 500) * 0.25;
	}
}

// Critical Damage = 120% + (Min(Dexterity,100) / 100) * 80%
class UMMC_Mage_CriticalDamage : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return float32(1.2 + (Math::Min(Dexterity,100) / 100) * 0.8);
	}
}

// Magic Resistance = Intelligence * 1.5
class UMMC_Mage_MagicResistance : UGameplayModMagnitudeCalculation {
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const {
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 1.5;
	}
}
