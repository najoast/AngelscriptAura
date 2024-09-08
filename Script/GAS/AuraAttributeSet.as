
namespace AuraAttributes
{
	// Primary Attributes
	const FName Strength    = n"Strength"; // 力量
	const FName Intellignce = n"Intellignce"; // 智力
	const FName Resilience  = n"Resilience"; // 抗性
	const FName Vigor       = n"Vigor"; // 精力

	// Secondary Attributes

	//  Defense Attributes
	const FName Armor            = n"Armor"; // 护甲
	const FName ArmorPenetration = n"ArmorPenetration"; // 护甲穿透
	const FName BlockChance      = n"BlockChance";

	//  Attack Attributes
	const FName CriticalHitChance     = n"CriticalHitChance"; // 暴击率
	const FName CriticalHitDamage     = n"CriticalHitDamage"; // 暴击伤害
	const FName CriticalHitResistance = n"CriticalHitResistance"; // 暴击抗性

	//  Vital Attributes
	const FName Health      = n"Health";
	const FName MaxHealth   = n"MaxHealth";
	const FName HealthRegen = n"HealthRegen"; // 生命回复
	const FName Mana        = n"Mana";
	const FName MaxMana     = n"MaxMana";
	const FName ManaRegen   = n"ManaRegen"; // 法力回复
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
	FAngelscriptGameplayAttributeData Intellignce;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
	FAngelscriptGameplayAttributeData Resilience;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Primary Attributes")
	FAngelscriptGameplayAttributeData Vigor;

	// Secondary Attributes

	//  Defense Attributes
	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Defense Attributes")
	FAngelscriptGameplayAttributeData Armor;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Defense Attributes")
	FAngelscriptGameplayAttributeData ArmorPenetration;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Defense Attributes")
	FAngelscriptGameplayAttributeData BlockChance;

	//  Attack Attributes
	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Attack Attributes")
	FAngelscriptGameplayAttributeData CriticalHitChance;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Attack Attributes")
	FAngelscriptGameplayAttributeData CriticalHitDamage;

	UPROPERTY(BlueprintReadOnly, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Attack Attributes")
	FAngelscriptGameplayAttributeData CriticalHitResistance;

	//  Vital Attributes
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
	private TMap<FName, FAngelscriptGameplayAttributeData> Name2Attribute;

	// ======================================================================================================

	// Events
	FOnGameplayEffectApplied OnGameplayEffectAppliedEvent;

	// Functions

	UAuraAttributeSet()
	{
		PrimaryAttributes.Add(Strength);
		PrimaryAttributes.Add(Intellignce);
		PrimaryAttributes.Add(Resilience);
		PrimaryAttributes.Add(Vigor);

		SecondaryAttributes.Add(Armor);
		SecondaryAttributes.Add(ArmorPenetration);
		SecondaryAttributes.Add(BlockChance);
		SecondaryAttributes.Add(CriticalHitChance);
		SecondaryAttributes.Add(CriticalHitDamage);
		SecondaryAttributes.Add(CriticalHitResistance);
		SecondaryAttributes.Add(MaxHealth);
		SecondaryAttributes.Add(HealthRegen);
		SecondaryAttributes.Add(MaxMana);
		SecondaryAttributes.Add(ManaRegen);

		for (FAngelscriptGameplayAttributeData& Attribute : PrimaryAttributes) {
			Name2Attribute.Add(Attribute.AttributeName, Attribute);
		}
		for (FAngelscriptGameplayAttributeData& Attribute : SecondaryAttributes) {
			Name2Attribute.Add(Attribute.AttributeName, Attribute);
		}
	}

	UFUNCTION()
	void OnRep_ReplicationTrampoline(FAngelscriptGameplayAttributeData& OldAttributeData)
	{
		Print(f"OnRep_ReplicationTrampoline: {OldAttributeData =}");
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