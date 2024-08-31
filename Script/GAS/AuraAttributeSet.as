
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
}