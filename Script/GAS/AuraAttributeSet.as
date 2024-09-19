
namespace AuraAttributes
{
	// 1 Primary Attributes
	const FName Strength     = n"Strength"; // 力量
	const FName Dexterity    = n"Dexterity"; // 敏捷
	const FName Intelligence = n"Intelligence"; // 智力
	const FName Vitality     = n"Vitality"; // 体质

	// 2 Secondary Attributes
	// 2.1 Attack Attributes
	const FName AttackPower     = n"AttackPower"; // 攻击力
	const FName MagicPower      = n"MagicPower"; // 魔法攻击力
	const FName CriticalChance  = n"CriticalChance"; // 暴击率
	const FName CriticalDamage  = n"CriticalDamage"; // 暴击伤害

	// 2.2 Defense Attributes
	const FName Defense         = n"Defense"; // 防御力
	const FName MagicResistance = n"MagicResistance"; // 法抗性
	const FName Accuracy        = n"Accuracy"; // 命中率
	const FName Evasion         = n"Evasion"; // 闪避率

	// 2.3 Vital Attributes
	const FName Health      = n"Health";
	const FName MaxHealth   = n"MaxHealth";
	const FName HealthRegen = n"HealthRegen"; // 生命回复
	const FName Mana        = n"Mana";
	const FName MaxMana     = n"MaxMana";
	const FName ManaRegen   = n"ManaRegen"; // 法力回复

	// 3 Tertiary Attributes
	const FName MinAttackPower  = n"MinAttackPower"; // 最小攻击力
	const FName MaxAttackPower  = n"MaxAttackPower"; // 最大攻击力
	const FName MinMagicPower   = n"MinMagicPower"; // 最小魔法攻击力
	const FName MaxMagicPower   = n"MaxMagicPower"; // 最大魔法攻击力
}

event void FOnGameplayEffectApplied(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC);

// Add GameplayAbilities/GameplayTags/GameplayTasks to Aura.Build.cs private dependencies
class UAuraAttributeSet : UAngelscriptAttributeSet
{
	// =================================== Attributes ===================================
	// Primary Attributes
	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
	FAngelscriptGameplayAttributeData Strength;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
	FAngelscriptGameplayAttributeData Dexterity;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
	FAngelscriptGameplayAttributeData Intelligence;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
	FAngelscriptGameplayAttributeData Vitality;

	// Secondary Attributes
	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData AttackPower;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData MinAttackPower;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData MaxAttackPower;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData MagicPower;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData MinMagicPower;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData MaxMagicPower;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData Defense;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData MagicResistance;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData Accuracy;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData Evasion;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData CriticalChance;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Secondary Attributes")
	FAngelscriptGameplayAttributeData CriticalDamage;

	// Vital Attributes
	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData Health;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData MaxHealth;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData HealthRegen;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData Mana;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData MaxMana;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData ManaRegen;

	// Varibles
	private TArray<FAngelscriptGameplayAttributeData> PrimaryAttributes;
	private TArray<FAngelscriptGameplayAttributeData> SecondaryAttributes;
	private TArray<FAngelscriptGameplayAttributeData> VitalAttributes;
	private TMap<FName, FAngelscriptGameplayAttributeData> Name2Attribute;

	// ======================================================================================================

	// Events
	FOnGameplayEffectApplied OnGameplayEffectAppliedEvent;

	// Functions

	void InitAttributesMapping()
	{
		PrimaryAttributes.Add(Strength);
		PrimaryAttributes.Add(Dexterity);
		PrimaryAttributes.Add(Intelligence);
		PrimaryAttributes.Add(Vitality);

		SecondaryAttributes.Add(AttackPower);
		SecondaryAttributes.Add(MinAttackPower);
		SecondaryAttributes.Add(MaxAttackPower);
		SecondaryAttributes.Add(MagicPower);
		SecondaryAttributes.Add(MinMagicPower);
		SecondaryAttributes.Add(MaxMagicPower);

		SecondaryAttributes.Add(Defense);
		SecondaryAttributes.Add(MagicResistance);
		SecondaryAttributes.Add(Accuracy);
		SecondaryAttributes.Add(Evasion);
		SecondaryAttributes.Add(CriticalChance);
		SecondaryAttributes.Add(CriticalDamage);

		SecondaryAttributes.Add(MaxHealth);
		SecondaryAttributes.Add(HealthRegen);
		SecondaryAttributes.Add(MaxMana);
		SecondaryAttributes.Add(ManaRegen);

		VitalAttributes.Add(Health);
		VitalAttributes.Add(Mana);

		for (FAngelscriptGameplayAttributeData& Attribute : PrimaryAttributes) {
			Name2Attribute.Add(Attribute.AttributeName, Attribute);
		}
		for (FAngelscriptGameplayAttributeData& Attribute : SecondaryAttributes) {
			Name2Attribute.Add(Attribute.AttributeName, Attribute);
		}
		for (FAngelscriptGameplayAttributeData& Attribute : VitalAttributes) {
			Name2Attribute.Add(Attribute.AttributeName, Attribute);
		}
	}

	UFUNCTION()
	void OnRep_ReplicationTrampoline(FAngelscriptGameplayAttributeData& OldAttributeData)
	{
		Print(f"OnRep_ReplicationTrampoline: {OldAttributeData.AttributeName =}");
		OnRep_Attribute(OldAttributeData);
	}

	FAngelscriptGameplayAttributeData& GetAttribute(FName AttributeName)
	{
		if (!Name2Attribute.Contains(AttributeName)) {
			Print(f"GetAttribute {AttributeName} is not found");
			check(false);
		}
		return Name2Attribute[AttributeName];
	}

	const TArray<FAngelscriptGameplayAttributeData>& GetPrimaryAttributes()
	{
		return PrimaryAttributes;
	}

	const TArray<FAngelscriptGameplayAttributeData>& GetSecondaryAttributes()
	{
		return SecondaryAttributes;
	}

	const TMap<FName, FAngelscriptGameplayAttributeData>& GetAllAttributes()
	{
		return Name2Attribute;
	}

	/*
		Clamping of `Attributes` is discussed in PreAttributeChange() for changes to the `CurrentValue`
		and PostGameplayEffectExecute() for changes to the `BaseValue` from `GameplayEffects`.

		Epic suggests that only should clamp the value in PreAttributeChange,
		don't execute complex logic in this function, eg: ApplyGameplayEffect
	*/
	UFUNCTION(BlueprintOverride)
	void PreAttributeChange(FGameplayAttribute Attribute, float32& NewValue)
	{
		ClampAttribute(Attribute, NewValue);
	}

	void ClampAttribute(FGameplayAttribute Attribute, float32& NewValue)
	{
		if (Attribute.AttributeName == AuraAttributes::Health) {
			// TODO: 检查一下这里为什么有时候 NewValue 会是0
			Print(f"Health OldValue: {Health.GetCurrentValue()} NewValue: {NewValue}");
			NewValue = Math::Clamp(NewValue, float32(0), MaxHealth.GetCurrentValue());
		} else if (Attribute.AttributeName == AuraAttributes::Mana) {
			NewValue = Math::Clamp(NewValue, float32(0), MaxMana.GetCurrentValue());
		}
	}

	UFUNCTION(BlueprintOverride)
	void PostGameplayEffectExecute(FGameplayEffectSpec EffectSpec,
								   FGameplayModifierEvaluatedData& EvaluatedData,
								   UAngelscriptAbilitySystemComponent TargetASC)
	{
		// Clamp the attribute value in PostGameplayEffectExecute.
		auto& Attribute = GetAttribute(FName(EvaluatedData.Attribute.AttributeName));
		float32 BaseValue = Attribute.GetBaseValue();
		ClampAttribute(EvaluatedData.Attribute, BaseValue);

		if (BaseValue != Attribute.GetBaseValue()) {
			Attribute.SetBaseValue(BaseValue);
		}

		// Print(f"PostGameplayEffectExecute: {EffectSpec =}");
		FEffectProperties Props;
		GetEffectProperties(Props, EffectSpec, TargetASC);

		// This event is broadcasted by OnGameplayEffectAppliedDelegateToSelf.Brocast() in the course.
		// Because there is no OnGameplayEffectAppliedDelegateToSelf in the Angelscript, so I just call this function via PostGameplayEffectExecute.
		OnGameplayEffectAppliedEvent.Broadcast(EffectSpec, EvaluatedData, TargetASC);
	}

	// This function is just a demostration of how to retrieve ASC info in PostGameplayEffectExecute.
	// Currently, there is no real gameplay logic in it.
	void GetEffectProperties(FEffectProperties& Props, FGameplayEffectSpec EffectSpec, UAngelscriptAbilitySystemComponent TargetASC)
	{
		Props.EffectContextHandle = EffectSpec.GetContext();
		Props.SourceASC = Cast<UAngelscriptAbilitySystemComponent>(Props.EffectContextHandle.GetOriginalInstigatorAbilitySystemComponent());
		RetrieveASCInfo(Props.SourceASC, Props.SourceAvatarActor, Props.SourceController, Props.SourceCharacter);
		Props.TargetASC = TargetASC;
		RetrieveASCInfo(Props.TargetASC, Props.TargetAvatarActor, Props.TargetController, Props.TargetCharacter);
	}

	void RetrieveASCInfo(UAngelscriptAbilitySystemComponent ASC, AActor& AvatarActor, AController& Controller, ACharacter& Character)
	{
		if (!IsValid(ASC)) {
			return;
		}
		AvatarActor = ASC.AbilityActorInfo.GetAvatarActor();
		Controller = ASC.AbilityActorInfo.GetPlayerController();
		if (Controller == nullptr && AvatarActor != nullptr) {
			const APawn Pawn = Cast<APawn>(AvatarActor);
			if (Pawn != nullptr) {
				Controller = Pawn.GetController();
			}
		}
		if (Controller != nullptr) {
			Character = Cast<ACharacter>(Controller.GetControlledPawn());
		}
	}
}
