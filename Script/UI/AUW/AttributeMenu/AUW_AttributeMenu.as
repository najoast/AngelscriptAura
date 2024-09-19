
class UAUW_AttributeMenu : UAuraUserWidget
{
	// ------------------------ Bind Widgets ------------------------

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_AttributePoints;

	// Primary Attributes
	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Strength;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Dexterity;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Intelligence;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Vitality;

	// Secondary Attributes
	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_AttackPower;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_MagicPower;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_CriticalChance;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_CriticalDamage;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Defense;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_MagicResistance;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Accuracy;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_Evasion;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_MaxHealth;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_HealthRegen;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_MaxMana;

	UPROPERTY(BindWidget)
	UAUW_TextValueRow WBP_ManaRegen;


	UPROPERTY(BindWidget)
	UAUW_Button WBP_Button_Close;

	// ------------------------ Member Variables ------------------------
	TMap<FName, UAUW_TextValueRow> PrimaryAttributeWidgets;
	TMap<FName, UAUW_TextValueRow> SecondaryAttributeWidgets;
	TMap<FName, UAUW_TextValueRow> AllAttributeWidgets;

	// ------------------------ Functions ------------------------


	void OnCtor() override
	{
		InitWidgetsDesignInfo();
		InitWidgetsData();

		WBP_Button_Close.Button.OnClicked.AddUFunction(this, n"OnButton_CloseClicked");
		AuraUtil::GameInstance().EventMgr.OnAttributeChangedEvent.AddUFunction(this, n"OnAttributeChanged");
	}

	void InitWidgetsDesignInfo()
	{
		WBP_AttributePoints.Text_Text.Text = FText::FromString("Attribute Points");

		PrimaryAttributeWidgets.Add(AuraAttributes::Strength, WBP_Strength);
		PrimaryAttributeWidgets.Add(AuraAttributes::Dexterity, WBP_Dexterity);
		PrimaryAttributeWidgets.Add(AuraAttributes::Intelligence, WBP_Intelligence);
		PrimaryAttributeWidgets.Add(AuraAttributes::Vitality, WBP_Vitality);

		SecondaryAttributeWidgets.Add(AuraAttributes::AttackPower, WBP_AttackPower);
		SecondaryAttributeWidgets.Add(AuraAttributes::MagicPower, WBP_MagicPower);
		SecondaryAttributeWidgets.Add(AuraAttributes::CriticalChance, WBP_CriticalChance);
		SecondaryAttributeWidgets.Add(AuraAttributes::CriticalDamage, WBP_CriticalDamage);
		SecondaryAttributeWidgets.Add(AuraAttributes::Defense, WBP_Defense);
		SecondaryAttributeWidgets.Add(AuraAttributes::MagicResistance, WBP_MagicResistance);
		SecondaryAttributeWidgets.Add(AuraAttributes::Accuracy, WBP_Accuracy);
		SecondaryAttributeWidgets.Add(AuraAttributes::Evasion, WBP_Evasion);
		SecondaryAttributeWidgets.Add(AuraAttributes::MaxHealth, WBP_Evasion);
		SecondaryAttributeWidgets.Add(AuraAttributes::HealthRegen, WBP_HealthRegen);
		SecondaryAttributeWidgets.Add(AuraAttributes::MaxMana, WBP_MaxMana);
		SecondaryAttributeWidgets.Add(AuraAttributes::ManaRegen, WBP_ManaRegen);

		// Add to AllAttributeWidgets
		for (auto Element : PrimaryAttributeWidgets) {
			AllAttributeWidgets.Add(Element.Key, Element.Value);
		}
		for (auto Element : SecondaryAttributeWidgets) {
			AllAttributeWidgets.Add(Element.Key, Element.Value);
		}

		// Primary Attributes
		for (auto Element : PrimaryAttributeWidgets)
		{
			FName AttributeName = Element.Key;
			Element.Value.Text_Text.Text = FText::FromString(AttributeName.ToString());
			Element.Value.WBP_Button_AddPoint.SetVisibility(ESlateVisibility::Visible);
			Element.Value.WBP_Button_AddPoint.Button.OnClicked.AddUFunction(this, FName(f"OnButton_Add{AttributeName}Clicked"));
		}

		// Secondary Attributes
		for (auto Element : SecondaryAttributeWidgets)
		{
			FName AttributeName = Element.Key;
			Element.Value.Text_Text.Text = FText::FromString(AttributeName.ToString());
		}

		WBP_Button_Close.Text.Text = FText::FromString("x");
	}

	void InitWidgetsData()
	{
		UGasModule GasModule = AuraUtil::GetCharacterGasModule(OwnerCharacter);
		for (auto Element : AllAttributeWidgets)
		{
			if (Element.Key == AuraAttributes::AttackPower) {
				float32 MinAttackPower = GasModule.GetAttributeValue(AuraAttributes::MinAttackPower);
				float32 MaxAttackPower = GasModule.GetAttributeValue(AuraAttributes::MaxAttackPower);
				Element.Value.WBP_FramedValue.Text_Value.SetText(FText::FromString(f"{MinAttackPower :.0} - {MaxAttackPower :.0}"));
			} else if (Element.Key == AuraAttributes::MagicPower) {
				float32 MinMagicPower = GasModule.GetAttributeValue(AuraAttributes::MinMagicPower);
				float32 MaxMagicPower = GasModule.GetAttributeValue(AuraAttributes::MaxMagicPower);
				Element.Value.WBP_FramedValue.Text_Value.SetText(FText::FromString(f"{MinMagicPower :.0} - {MaxMagicPower :.0}"));
			} else {
				float32 Value = GasModule.GetAttributeValue(Element.Key);
				Element.Value.WBP_FramedValue.Text_Value.SetText(FText::FromString(f"{Value :.0}"));
			}
		}
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
	void OnButton_AddDexterityClicked()
	{
		Print("OnButton_AddDexterityClicked");
	}

	UFUNCTION()
	void OnButton_AddIntelligenceClicked()
	{
		Print("OnButton_AddIntelligenceClicked");
	}

	UFUNCTION()
	void OnButton_AddVitalityClicked()
	{
		Print("OnButton_AddVitalityClicked");
	}

	UFUNCTION()
	private void OnAttributeChanged(FAngelscriptModifiedAttribute AttributeChangeData)
	{
		if (!AllAttributeWidgets.Contains(AttributeChangeData.Name)) {
			return;
		}

		UGasModule GasModule = AuraUtil::GetCharacterGasModule(OwnerCharacter);
		UAUW_TextValueRow TextValueRow = AllAttributeWidgets[AttributeChangeData.Name];
		float32 Value = GasModule.GetAttributeValue(AttributeChangeData.Name);
		TextValueRow.Text_Text.SetText(FText::FromString(f"{Value :.0}"));
	}
}
