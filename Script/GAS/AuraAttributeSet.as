
namespace AuraAttributes
{
	const FName Health = n"Health";
	const FName MaxHealth = n"MaxHealth";
	const FName Mana = n"Mana";
	const FName MaxMana = n"MaxMana";
}

// Add GameplayAbilities/GameplayTags/GameplayTasks to Aura.Build.cs private dependencies
class UAuraAttributeSet : UAngelscriptAttributeSet
{
	// Attributes
	UPROPERTY(BlueprintReadOnly, Replicated, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData Health;

	UPROPERTY(BlueprintReadOnly, Replicated, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData MaxHealth;

	UPROPERTY(BlueprintReadOnly, Replicated, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData Mana;

	UPROPERTY(BlueprintReadOnly, Replicated, ReplicatedUsing = OnRep_ReplicationTrampoline, Category = "Vital Attributes")
	FAngelscriptGameplayAttributeData MaxMana;

	// Functions
	UAuraAttributeSet()
	{
		Health.Initialize(10);
		MaxHealth.Initialize(100);
		Mana.Initialize(0);
		MaxMana.Initialize(50);
	}

	UFUNCTION()
	void OnRep_ReplicationTrampoline(FAngelscriptGameplayAttributeData& OldAttributeData)
	{
		Print(f"OnRep_ReplicationTrampoline: {OldAttributeData =}");
		OnRep_Attribute(OldAttributeData);
	}

	const FAngelscriptGameplayAttributeData& GetAttribute(FName AttributeName)
	{
		if (AttributeName == AuraAttributes::Health) return Health;
		if (AttributeName == AuraAttributes::MaxHealth) return MaxHealth;
		if (AttributeName == AuraAttributes::Mana) return Mana;
		if (AttributeName == AuraAttributes::MaxMana) return MaxMana;
		check(false);
		return Health;
	}

	// Epic suggests that only should clamp the value in PreAttributeChange,
	// don't execute complex logic in this function, eg: ApplyGameplayEffect
	UFUNCTION(BlueprintOverride)
	void PreAttributeChange(FGameplayAttribute Attribute, float32& NewValue)
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
		// Print(f"PostGameplayEffectExecute: {EffectSpec =}");
		FEffectProperties Props;
		GetEffectProperties(Props, EffectSpec, TargetASC);
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