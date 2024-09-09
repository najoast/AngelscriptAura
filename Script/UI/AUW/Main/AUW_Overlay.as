

class UAUW_Overlay : UAuraUserWidget
{
	// -------------------------------------

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeHealth;

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeMana;

	UPROPERTY(BindWidget)
	UAUW_Button WBP_WideButton_Attributes;

	// -------------------------------------

	UFUNCTION(BlueprintOverride)
	void Construct()
	{
		FSlateBrush ManaBrush;
		ManaBrush.ResourceObject = LoadObject(this, "/Game/Assets/UI/Globes/MI_ManaGlobe");
		WBP_GlobeMana.ProgressBar_Main.WidgetStyle.FillImage = ManaBrush;

		WBP_WideButton_Attributes.Button.OnClicked.AddUFunction(this, n"OnButton_AttributesClicked");
		AuraUtil::GameInstance().EventMgr.OnWidgetClosedEvent.AddUFunction(this, n"OnWidgetClosed");
		AuraUtil::GameInstance().EventMgr.OnAttributeChangedEvent.AddUFunction(this, n"OnAttributeChanged");
	}

	// void OnWidgetControllerSet() override
	// {
	// 	Print("OnWidgetControllerSet");
	// 	check(WidgetController.AbilitySystemComponent != nullptr);
	// }

	// UFUNCTION()
	// void OnAttributeSetRegistered(UAngelscriptAttributeSet NewAttributeSet)
	// {
	// 	UpdateWidgets();
	// }

	// https://github.com/Hazelight/UnrealEngine-Angelscript/blob/angelscript-master/Script-Examples/GASExamples/Example_GASAnimInstance.as
	UFUNCTION()
	private void OnAttributeChanged(FAngelscriptModifiedAttribute AttributeChangeData)
	{
		// TODO: Only vital attributes need update
		UpdateWidgets();
	}

	void UpdateWidgets()
	{
		UPlayerGasModule PlayerGasModule = AuraUtil::GetPlayerGasModule(WidgetController.Character);
		float32 Health = PlayerGasModule.GetAttributeValue(AuraAttributes::Health);
		float32 MaxHealth = PlayerGasModule.GetAttributeValue(AuraAttributes::MaxHealth);
		WBP_GlobeHealth.SetPercent(Health, MaxHealth);

		float32 Mana = PlayerGasModule.GetAttributeValue(AuraAttributes::Mana);
		float32 MaxMana = PlayerGasModule.GetAttributeValue(AuraAttributes::MaxMana);
		WBP_GlobeMana.SetPercent(Mana, MaxMana);
	}

	UFUNCTION()
	void OnButton_AttributesClicked()
	{
		UAUW_AttributeMenu AttributeMenu = Cast<UAUW_AttributeMenu>(WidgetUtil::OpenWidget(n"AttributeMenu", WidgetController.PlayerController, FVector2D(30, 30)));
		if (AttributeMenu != nullptr) {
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
}
