
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
		InitWidgetsInfo();
		Update();

		WBP_Button_Close.Button.OnClicked.AddUFunction(this, n"OnButton_CloseClicked");
	}

	void InitWidgetsInfo()
	{
		WBP_AttributePoints.Text_Text.Text = FText::FromString("Attribute Points");

		TMap<FName, UAUW_TextValueRow> PrimaryAttributeWidgets;
		PrimaryAttributeWidgets.Add(AuraAttributes::Strength, WBP_Strength);
		PrimaryAttributeWidgets.Add(AuraAttributes::Intellignce, WBP_Intelligence);
		PrimaryAttributeWidgets.Add(AuraAttributes::Resilience, WBP_Resislience);
		PrimaryAttributeWidgets.Add(AuraAttributes::Vigor, WBP_Vigor);

		TMap<FName, UAUW_TextValueRow> SecondaryAttributeWidgets;
		SecondaryAttributeWidgets.Add(AuraAttributes::Armor, WBP_Armor);
		SecondaryAttributeWidgets.Add(AuraAttributes::ArmorPenetration, WBP_ArmorPenetration);
		SecondaryAttributeWidgets.Add(AuraAttributes::BlockChance, WBP_BlockChance);
		SecondaryAttributeWidgets.Add(AuraAttributes::CriticalHitChance, WBP_CriticalHitChance);
		SecondaryAttributeWidgets.Add(AuraAttributes::CriticalHitDamage, WBP_CriticalHitDamage);
		SecondaryAttributeWidgets.Add(AuraAttributes::CriticalHitResistance, WBP_CriticalHitResistance);
		SecondaryAttributeWidgets.Add(AuraAttributes::MaxHealth, WBP_MaxHealth);
		SecondaryAttributeWidgets.Add(AuraAttributes::HealthRegen, WBP_HealthRegen);
		SecondaryAttributeWidgets.Add(AuraAttributes::MaxMana, WBP_MaxMana);
		SecondaryAttributeWidgets.Add(AuraAttributes::ManaRegen, WBP_ManaRegen);

		// Primary Attributes
		for (auto Element : PrimaryAttributeWidgets)
		{
			FName AttributeName = Element.Key;
			Element.Value.Text_Text.Text = FText::FromString(AttributeName.ToString());
			Element.Value.WBP_Button_AddPoint.Button.SetVisibility(ESlateVisibility::Visible);
			Element.Value.WBP_Button_AddPoint.Button.OnClicked.AddUFunction(this, FName(f"OnButton_Add{AttributeName}Clicked"));
		}

		// Secondary Attributes
		for (auto Element : SecondaryAttributeWidgets)
		{
			FName AttributeName = Element.Key;
			Element.Value.Text_Text.Text = FText::FromString(AttributeName.ToString());
		}
	}

	void Update()
	{

	}

	UFUNCTION()
	void OnButton_CloseClicked()
	{
		WidgetUtil::CloseWidget(this);
	}

	UFUNCTION()
	void OnButton_AddStrengthClicked()
	{
		Print("OnButton_AddStrengthClicked");
	}

	UFUNCTION()
	void OnButton_AddIntelligenceClicked()
	{
		Print("OnButton_AddIntelligenceClicked");
	}

	UFUNCTION()
	void OnButton_AddResilienceClicked()
	{
		Print("OnButton_AddResilienceClicked");
	}

	UFUNCTION()
	void OnButton_AddVigorClicked()
	{
		Print("OnButton_AddVigorClicked");
	}
}
