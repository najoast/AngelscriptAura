
// MaxHealth = Vitality * 20
class UMMC_Warrior_MaxHealth : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Vitality * 20;
	}
}

// MaxMana = Intelligence * 5
class UMMC_Warrior_MaxMana : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 5;
	}
}

// Health Regen = Vitality * 0.5
class UMMC_Warrior_HealthRegen : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Vitality * 0.5;
	}
}

// Mana Regen = Intelligence * 0.1
class UMMC_Warrior_ManaRegen : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 0.1;
	}
}

// Attack Power = Strength * 2 + Dexterity * 0.5
class UMMC_Warrior_AttackPower : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition StrengthCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute StrengthAttribute;
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(StrengthCaptureDefinition);
	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default StrengthAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength");
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Strength = GetCapturedAttributeMagnitude(Spec, StrengthAttribute, SourceTags, TargetTags);
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return Strength * 2 + Dexterity * 0.5;
	}
}

// Magic Power = Intelligence * 1.5
class UMMC_Warrior_MagicPower : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 1.5;
	}
}

// Defense = Strength * 1.5 + Vitality * 0.5
class UMMC_Warrior_Defense : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition StrengthCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition VitalityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute StrengthAttribute;
	FGameplayAttribute VitalityAttribute;

	default RelevantAttributesToCapture.Add(StrengthCaptureDefinition);
	default RelevantAttributesToCapture.Add(VitalityCaptureDefinition);
	default StrengthAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Strength");
	default VitalityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Vitality");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Strength = GetCapturedAttributeMagnitude(Spec, StrengthAttribute, SourceTags, TargetTags);
		float32 Vitality = GetCapturedAttributeMagnitude(Spec, VitalityAttribute, SourceTags, TargetTags);
		return Strength * 1.5 + Vitality * 0.5;
	}
}

// Accuracy = 0.5 + (Dexterity / 200)
class UMMC_Warrior_Accuracy : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.5 + (Dexterity / 200);
	}
}

// Evasion = 0.2 + (Dexterity / 200)
class UMMC_Warrior_Evasion : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.2 + (Dexterity / 200);
	}
}

// Critical Chance = 0.05 + (Dexterity / 400) * 0.25
class UMMC_Warrior_CriticalChance : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return 0.05 + (Dexterity / 400) * 0.25;
	}
}

// Critical Damage = 120% + (Min(Dexterity,100) / 100) * 80%
class UMMC_Warrior_CriticalDamage : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition DexterityCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute DexterityAttribute;

	default RelevantAttributesToCapture.Add(DexterityCaptureDefinition);
	default DexterityAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Dexterity");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Dexterity = GetCapturedAttributeMagnitude(Spec, DexterityAttribute, SourceTags, TargetTags);
		return float32(1.2 + (Math::Min(Dexterity,100) / 100) * 0.8);
	}
}

// Magic Resistance = Intelligence * 0.5
class UMMC_Warrior_MagicResistance : UGameplayModMagnitudeCalculation
{
	FGameplayEffectAttributeCaptureDefinition IntelligenceCaptureDefinition = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence", EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayAttribute IntelligenceAttribute;

	default RelevantAttributesToCapture.Add(IntelligenceCaptureDefinition);
	default IntelligenceAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), n"Intelligence");

	UFUNCTION(BlueprintOverride)
	float32 CalculateBaseMagnitude(FGameplayEffectSpec Spec) const
	{
		FGameplayTagContainer SourceTags = Spec.CapturedSourceTags.AggregatedTags;
		FGameplayTagContainer TargetTags = Spec.CapturedTargetTags.AggregatedTags;
		float32 Intelligence = GetCapturedAttributeMagnitude(Spec, IntelligenceAttribute, SourceTags, TargetTags);
		return Intelligence * 0.5;
	}
}
