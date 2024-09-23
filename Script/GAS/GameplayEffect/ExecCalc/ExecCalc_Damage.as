
class UExecCalc_Damage : UGameplayEffectExecutionCalculation
{
	// Attacker Attributes
	FGameplayEffectAttributeCaptureDefinition SourceMinAttackPowerDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::MinAttackPower, EGameplayEffectAttributeCaptureSource::Source, true);
	FGameplayEffectAttributeCaptureDefinition SourceMaxAttackPowerDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::MaxAttackPower, EGameplayEffectAttributeCaptureSource::Source, true);
	FGameplayEffectAttributeCaptureDefinition SourceMinMagicPowerDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::MinMagicPower, EGameplayEffectAttributeCaptureSource::Source, true);
	FGameplayEffectAttributeCaptureDefinition SourceMaxMagicPowerDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::MaxMagicPower, EGameplayEffectAttributeCaptureSource::Source, true);
	FGameplayEffectAttributeCaptureDefinition SourceAccuracyDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::Accuracy, EGameplayEffectAttributeCaptureSource::Source, true);
	FGameplayEffectAttributeCaptureDefinition SourceCriticalChanceDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::CriticalChance, EGameplayEffectAttributeCaptureSource::Source, true);
	FGameplayEffectAttributeCaptureDefinition SourceCriticalDamageDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::CriticalDamage, EGameplayEffectAttributeCaptureSource::Source, true);

	// Victim Attributes
	FGameplayEffectAttributeCaptureDefinition TargetEvasionDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::Evasion, EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition TargetDefenseDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::Defense, EGameplayEffectAttributeCaptureSource::Target, false);
	FGameplayEffectAttributeCaptureDefinition TargetMagicResistanceDef = UAngelscriptGameplayEffectUtils::CaptureGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::MagicResistance, EGameplayEffectAttributeCaptureSource::Target, false);

	default RelevantAttributesToCapture.Add(SourceMinAttackPowerDef);
	default RelevantAttributesToCapture.Add(SourceMaxAttackPowerDef);
	default RelevantAttributesToCapture.Add(SourceMinMagicPowerDef);
	default RelevantAttributesToCapture.Add(SourceMaxMagicPowerDef);
	default RelevantAttributesToCapture.Add(SourceAccuracyDef);
	default RelevantAttributesToCapture.Add(SourceCriticalChanceDef);
	default RelevantAttributesToCapture.Add(SourceCriticalDamageDef);
	default RelevantAttributesToCapture.Add(TargetEvasionDef);
	default RelevantAttributesToCapture.Add(TargetDefenseDef);
	default RelevantAttributesToCapture.Add(TargetMagicResistanceDef);

	UFUNCTION(BlueprintOverride)
	void Execute(FGameplayEffectCustomExecutionParameters ExecutionParams, FGameplayEffectCustomExecutionOutput& OutExecutionOutput) const
	{
		UAbilitySystemComponent SourceASC = ExecutionParams.GetSourceAbilitySystemComponent();
		UAbilitySystemComponent TargetASC = ExecutionParams.GetTargetAbilitySystemComponent();

		AActor SourceActor = SourceASC.GetOwner();
		AActor TargetActor = TargetASC.GetOwner();

		// 这个 EffectSpec 是原版 Spec 的一个拷贝，所以对其作的任何修改都不会出这个函数
		FGameplayEffectSpec EffectSpec = ExecutionParams.GetOwningSpec();

		FGameplayEffectExecutionParameters EvalParams;
		EvalParams.SetIncludePredictiveMods(true);

		// 是否命中
		float32 SourceAccuracy = GetAttributeMagnitude(ExecutionParams, SourceAccuracyDef, EvalParams);
		float32 TargetEvasion = GetAttributeMagnitude(ExecutionParams, TargetEvasionDef, EvalParams);
		bool bIsHit = Math::RandRange(0, 1) < Math::Clamp((SourceAccuracy - TargetEvasion), AuraConst::HitChanceMin, AuraConst::HitChanceMax);
		if (!bIsHit) {
			SetDamage(OutExecutionOutput, 0, EDamageType::Miss);
			return;
		}

		EDamageType DamageType = EDamageType::None;

		// 计算攻击力 // TODO: 暂时只使用 AttackPower
		float32 SourceMinAttackPower = GetAttributeMagnitude(ExecutionParams, SourceMinAttackPowerDef, EvalParams);
		float32 SourceMaxAttackPower = GetAttributeMagnitude(ExecutionParams, SourceMaxAttackPowerDef, EvalParams);
		float32 SourceAttackPower = Math::RandRange(SourceMinAttackPower, SourceMaxAttackPower);

		// 如果随机到伤害范围的前 X%，就算是幸运一击
		if (SourceAttackPower >= (SourceMaxAttackPower-SourceMinAttackPower)*AuraConst::LuckyDamageRatio + SourceMinAttackPower) {
			// 都是无效修改，因为 EffectSpec 是原版 Spec 的一个拷贝，这里留着这两行注释，就是为了说明当时在这里踩过的坑
			// EffectSpec.AddDynamicAssetTag(GameplayTags::Damage_Lucky); 
			// EffectSpec.SetByCallerTagMagnitudes.Add(GameplayTags::Damage_Lucky, 0);
			DamageType = EDamageType::Lucky;
		}

		// 计算伤害
		float32 TargetDefense = GetAttributeMagnitude(ExecutionParams, TargetDefenseDef, EvalParams);
		float32 Damage = Math::Max(float32(1), SourceAttackPower - TargetDefense);

		// 计算暴击
		float32 SourceCriticalChance = GetAttributeMagnitude(ExecutionParams, SourceCriticalChanceDef, EvalParams);
		bool bIsCrit = Math::RandRange(0, 1) < SourceCriticalChance;
		if (bIsCrit) {
			float32 SourceCriticalDamage = GetAttributeMagnitude(ExecutionParams, SourceCriticalDamageDef, EvalParams);
			Damage *= Math::Clamp(SourceCriticalDamage, AuraConst::CritDamageMin, AuraConst::CritDamageMax);
			DamageType = EDamageType::Critical;
		}

		SetDamage(OutExecutionOutput, Damage, DamageType);
	}

	float32 GetAttributeMagnitude(FGameplayEffectCustomExecutionParameters ExecutionParams, FGameplayEffectAttributeCaptureDefinition CaptureDef, FGameplayEffectExecutionParameters EvalParams) const
	{
		float32 AttributeMagnitude = 0;
		if (ExecutionParams.AttemptCalculateCapturedAttributeMagnitude(CaptureDef, EvalParams, AttributeMagnitude)) {
			return AttributeMagnitude;
		}
		return 0;
	}

	void SetDamage(FGameplayEffectCustomExecutionOutput& OutExecutionOutput, float32 Damage, EDamageType DamageType) const
	{
		FGameplayAttribute IncomingDamageAttribute = UAngelscriptAttributeSet::GetGameplayAttribute(UAuraAttributeSet::StaticClass(), AuraAttributes::IncomingDamage);
		FGameplayModifierEvaluatedData EvaluatedData;
		EvaluatedData.SetAttribute(IncomingDamageAttribute);
		EvaluatedData.SetModifierOp(EGameplayModOp::Override);
		EvaluatedData.SetMagnitude(CombatUtil::EncodeDamage(Damage, DamageType));
		OutExecutionOutput.AddOutputModifier(EvaluatedData);
	}
}
