

class UAUW_Overlay : UAuraUserWidget
{
	// -------------------------------------

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeHealth;

	UPROPERTY(BindWidget)
	UAUW_GlobeProgressBar WBP_GlobeMana;

	// -------------------------------------

	TMap<FName, float32> CachedAttributeValues;

	// -------------------------------------

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

		Print(f"OnAttributeSetRegistered {NewAttributeSet.Name}");

		// Here we use the auxillary namespace to avoid having magic strings in our code as much as possible.
		// 不知道为什么这种方法不生效，下面的方法是自己翻源码时翻到的，试了下是生效的，但每次只能注册一个属性
		WidgetController.AbilitySystemComponent.OnAttributeChanged.AddUFunction(this, n"OnAttributeChanged");
		auto ASC = WidgetController.AbilitySystemComponent;
		// ASC.RegisterAttributeChangedCallback(AttributeSetClass, n"Health", this, n"OnAttributeChanged");
		//看C++源码，这样注册下才会回调到OnAttributeChangedTrampoline里，这里才会Broadcast，坑！不过有C++源码，没有看代码解决不了的问题。
		ASC.RegisterCallbackForAttribute(AttributeSetClass, AuraAttributes::Health);
		ASC.RegisterCallbackForAttribute(AttributeSetClass, AuraAttributes::MaxHealth);
		ASC.RegisterCallbackForAttribute(AttributeSetClass, AuraAttributes::Mana);
		ASC.RegisterCallbackForAttribute(AttributeSetClass, AuraAttributes::MaxMana);

		UpdateWidgets();
	}

	// https://github.com/Hazelight/UnrealEngine-Angelscript/blob/angelscript-master/Script-Examples/GASExamples/Example_GASAnimInstance.as
	UFUNCTION()
	private void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{
		Print(f"OnAttributeChanged: {AttributeChangeData.Name =}, {AttributeChangeData.NewValue =}");
		CachedAttributeValues.Add(AttributeChangeData.Name, AttributeChangeData.NewValue);
		UpdateWidgets();
	}

	float32 GetAttributeValue(FName AttributeName)
	{
		if (!CachedAttributeValues.Contains(AttributeName)) {
			CachedAttributeValues.Add(AttributeName, WidgetController.AttributeSet.GetAttribute(AttributeName).GetCurrentValue());
		}
		return CachedAttributeValues[AttributeName];
	}

	void UpdateWidgets()
	{
		float32 Health = GetAttributeValue(AuraAttributes::Health);
		float32 MaxHealth = GetAttributeValue(AuraAttributes::MaxHealth);
		WBP_GlobeHealth.ProgressBar.SetPercent(Health / MaxHealth);

		float32 Mana = GetAttributeValue(AuraAttributes::Mana);
		float32 MaxMana = GetAttributeValue(AuraAttributes::MaxMana);
		WBP_GlobeMana.ProgressBar.SetPercent(Mana / MaxMana);
	}
}
