
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
	}

	void OnWidgetControllerSet() override
	{
		Print("OnWidgetControllerSet");
		check(WidgetController.AbilitySystemComponent != nullptr);
		WidgetController.AbilitySystemComponent.OnAttributeSetRegistered(this, n"OnAttributeSetRegistered");
	}

	UFUNCTION()
	void OnAttributeSetRegistered(UAngelscriptAttributeSet NewAttributeSet)
	{
		// In here, we can register our attribute callback, and also hook up the callback itself.
		auto AttributeSetClass = UAuraAttributeSet::StaticClass();
		if (!NewAttributeSet.IsA(AttributeSetClass)) {
			return;
		}

		Print("OnAttributeSetRegistered");

		// Here we use the auxillary namespace to avoid having magic strings in our code as much as possible.
		// 不知道为什么这种方法不生效，下面的方法是自己翻源码时翻到的，试了下是生效的，但每次只能注册一个属性
		WidgetController.AbilitySystemComponent.OnAttributeChanged.AddUFunction(this, n"OnAttributeChanged");
		auto ASC = WidgetController.AbilitySystemComponent;
		// ASC.RegisterAttributeChangedCallback(AttributeSetClass, n"Health", this, n"OnAttributeChanged");
		ASC.RegisterCallbackForAttribute(AttributeSetClass, n"Health");//看C++源码，这样注册下才会回调到OnAttributeChangedTrampoline里，这里才会Broadcast，坑！不过有C++源码，没有看代码解决不了的问题。
		ASC.RegisterCallbackForAttribute(AttributeSetClass, n"Mana");
	}

	// https://github.com/Hazelight/UnrealEngine-Angelscript/blob/angelscript-master/Script-Examples/GASExamples/Example_GASAnimInstance.as
	UFUNCTION()
	private void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{
		Print("OnAttributeChanged: " + AttributeChangeData.Name);
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
