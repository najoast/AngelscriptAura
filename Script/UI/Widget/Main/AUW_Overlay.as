
class UAUW_Overlay : UAuraUserWidget
{
	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeHealth;

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeMana;

	UFUNCTION(BlueprintOverride)
	void Construct()
	{
		FSlateBrush ManaBrush;
		ManaBrush.ResourceObject = LoadObject(this, "/Game/Assets/UI/Globes/MI_ManaGlobe");
		WBP_GlobeMana.ProgressBar.WidgetStyle.FillImage = ManaBrush;

		if (WidgetController.AbilitySystemComponent != nullptr)
		{
			WidgetController.AbilitySystemComponent.OnAttributeChanged.AddUFunction(this, n"OnAttributeChanged");
		}
	}

	// https://github.com/Hazelight/UnrealEngine-Angelscript/blob/angelscript-master/Script-Examples/GASExamples/Example_GASAnimInstance.as
	UFUNCTION()
	private void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{
		if (AttributeChangeData.Name == n"Health")
		{
			float32 MaxHealth = WidgetController.AttributeSet.MaxHealth.GetCurrentValue();
			WBP_GlobeHealth.ProgressBar.SetPercent(AttributeChangeData.NewValue / MaxHealth);
		}
		else if (AttributeChangeData.Name == n"Mana")
		{
			float32 MaxMana = WidgetController.AttributeSet.MaxMana.GetCurrentValue();
			WBP_GlobeMana.ProgressBar.SetPercent(AttributeChangeData.NewValue / MaxMana);
		}
	}
}
