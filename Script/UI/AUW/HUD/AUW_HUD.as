

class UAUW_HUD : UAuraUserWidget
{
	// -------------------------------------

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeHealth;

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeMana;

	UPROPERTY(BindWidget)
	UAUW_Button WBP_WideButton_Attributes;

	// -------------------------------------

	void OnCtor() override
	{
		FSlateBrush ManaBrush;
		ManaBrush.ResourceObject = LoadObject(this, "/Game/Assets/UI/Globes/MI_ManaGlobe");
		WBP_GlobeMana.ProgressBar_Main.WidgetStyle.FillImage = ManaBrush;

		WBP_WideButton_Attributes.Button.OnClicked.AddUFunction(this, n"OnButton_AttributesClicked");
		AuraUtil::GameInstance().EventMgr.OnWidgetClosedEvent.AddUFunction(this, n"OnWidgetClosed");
		AuraUtil::GameInstance().EventMgr.OnAttributeChangedEvent.AddUFunction(this, n"OnAttributeChanged");

		RegisterAllWidgetsEvent();
	}

	// https://github.com/Hazelight/UnrealEngine-Angelscript/blob/angelscript-master/Script-Examples/GASExamples/Example_GASAnimInstance.as
	UFUNCTION()
	private void OnAttributeChanged(FAngelscriptModifiedAttribute AttributeChangeData)
	{
		UpdateWidgets(AttributeChangeData);
	}

	void UpdateWidgets(FAngelscriptModifiedAttribute AttributeChangeData)
	{
		UGasModule GasModule = AuraUtil::GetCharacterGasModule(OwnerCharacter);
		if (AttributeChangeData.Name == AuraAttributes::Health || AttributeChangeData.Name == AuraAttributes::MaxHealth)
		{
			float32 Health = GasModule.GetAttributeValue(AuraAttributes::Health);
			float32 MaxHealth = GasModule.GetAttributeValue(AuraAttributes::MaxHealth);
			WBP_GlobeHealth.SetPercent(Health, MaxHealth);
		}

		if (AttributeChangeData.Name == AuraAttributes::Mana || AttributeChangeData.Name == AuraAttributes::MaxMana)
		{
			float32 Mana = GasModule.GetAttributeValue(AuraAttributes::Mana);
			float32 MaxMana = GasModule.GetAttributeValue(AuraAttributes::MaxMana);
			WBP_GlobeMana.SetPercent(Mana, MaxMana);
		}
	}

	UFUNCTION()
	void OnButton_AttributesClicked()
	{
		UAUW_AttributeMenu AttributeMenu = Cast<UAUW_AttributeMenu>(WidgetUtil::OpenWidget(n"AttributeMenu", OwnerCharacter, FVector2D(30, 30)));
		if (AttributeMenu != nullptr)
		{
			// AttributeMenu
			WBP_WideButton_Attributes.SetIsEnabled(false);
		}
	}

	UFUNCTION()
	void OnWidgetClosed(UUserWidget UserWidget)
	{
		if (UserWidget.IsA(UAUW_AttributeMenu))
		{
			WBP_WideButton_Attributes.SetIsEnabled(true);
		}
	}

	void RegisterAllWidgetsEvent()
	{
		auto EventMgr = AuraUtil::GameInstance().EventMgr;
		EventMgr.OnItemPickedUpEvent.AddUFunction(this, n"OnItemPickedUp");
	}

	UFUNCTION()
	void OnItemPickedUp(EItemID ItemID)
	{
		FSDataItem Item = SDataUtil::GetItem(ItemID);
		if (Item.ID == EItemID::None) {
			Print(f"Item {ItemID} is not found");
			return;
		}

		APlayerController PlayerController = OwnerCharacter.GetLocalViewingPlayerController();
		FVector2D Position = WidgetUtil::GetViewportPositionByRatio(PlayerController, 0.5);
		UAUW_PickupMsg AUW_PickupMsg = Cast<UAUW_PickupMsg>(WidgetUtil::OpenWidget(n"PickupMsg", OwnerCharacter, Position));
		if (AUW_PickupMsg != nullptr) {
			AUW_PickupMsg.Image_Icon.SetBrushFromTexture(Item.Icon);
			FText Text = FText::FromString(f"Picked up a {Item.Name}");
			AUW_PickupMsg.TextBox_Msg.SetText(Text);
		}
	}
}
