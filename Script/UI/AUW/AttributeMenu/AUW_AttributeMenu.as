
class UAUW_AttributeMenu : UAuraUserWidget
{
	// ------------------------ Bind Widgets ------------------------

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

	UPROPERTY(BindWidget)
	UAUW_Button WBP_Button_Close;

	// ------------------------ Member Variables ------------------------
	// UAUW_Button 

	// ------------------------ Functions ------------------------

	UFUNCTION(BlueprintOverride)
	void OnInitialized()
	{
		Update();

		WBP_Button_Close.Button.OnClicked.AddUFunction(this, n"OnButton_CloseClicked");
	}

	void Update()
	{

	}

	UFUNCTION()
	void OnButton_CloseClicked()
	{
		WidgetUtil::CloseWidget(this);
	}

	UFUNCTION(BlueprintOverride)
	void Destruct()
	{
		
	}
}
