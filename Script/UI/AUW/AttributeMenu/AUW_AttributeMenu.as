
class UAUW_AttributeMenu : UAuraUserWidget
{
	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_AttributePoints;

	// Primary Attributes
	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Strength;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Intelligence;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Resislience;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Vigor;

	// Secondary Attributes
	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Armor;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_ArmorPenetration;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_BlockChance;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_CriticalHitChance;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_CriticalHitDamage;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_CriticalHitResistance;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_MaxHealth;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_HealthRegen;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_MaxMana;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_ManaRegen;

	// Vital Attributes
	// UPROPERTY(BindWidget)
	// UAUW_VitalProgress WBP_Health;

	// UPROPERTY(BindWidget)
	// UAUW_VitalProgress WBP_Mana;

	UFUNCTION(BlueprintOverride)
	void OnInitialized()
	{
		Update();
	}

	void Update()
	{

	}
}
