
class UGasModule : UObject
{
	// -------------------- Varibles --------------------
	AAuraCharacterBase OwnerCharacter;

	private TMap<FName, float32> CachedAttributeValues;
	private UAuraAttributeSet AttributeSet;

	// -------------------- Functions --------------------
	void Init(AAuraCharacterBase InOwnerCharacter)
	{
		OwnerCharacter = InOwnerCharacter;

		UAngelscriptAbilitySystemComponent ASC = OwnerCharacter.AbilitySystem;
		ASC.OnAttributeSetRegistered(this, n"OnAttributeSetRegistered");

		// This is how we register an attribute set with an actor.
		AttributeSet = Cast<UAuraAttributeSet>(ASC.RegisterAttributeSet(UAuraAttributeSet::StaticClass()));
		ASC.InitAbilityActorInfo(OwnerCharacter, OwnerCharacter);
	}

	UAngelscriptAbilitySystemComponent GetASC()
	{
		return OwnerCharacter.AbilitySystem;
	}

	UFUNCTION()
	void OnAttributeSetRegistered(UAngelscriptAttributeSet NewAttributeSet)
	{
		UAuraAttributeSet AuraAttributeSet = Cast<UAuraAttributeSet>(NewAttributeSet);
		if (AuraAttributeSet == nullptr) {
			Print(f"OnAttributeSetRegistered {NewAttributeSet.Name} is not UAuraAttributeSet");
			return;
		}

		AuraAttributeSet.InitAttributesMapping();

		UAngelscriptAbilitySystemComponent ASC = this.GetASC();

		// 不知道为什么这种方法不生效，下面的方法是自己翻源码时翻到的，试了下是生效的，但每次只能注册一个属性
		// ASC.RegisterAttributeChangedCallback(AttributeSetClass, n"Health", this, n"OnAttributeChanged");

		ASC.OnAttributeChanged.AddUFunction(this, n"OnAttributeChanged");

		// 看C++源码，这样注册下才会回调到OnAttributeChangedTrampoline里，这里才会Broadcast
		UClass AttributeSetClass = AuraAttributeSet.GetClass();
		for (auto Element : AuraAttributeSet.GetAllAttributes())
		{
			FName AttributeName = Element.Key;
			ASC.RegisterCallbackForAttribute(AttributeSetClass, AttributeName);
		}
	}

	UFUNCTION()
	private void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{
		CachedAttributeValues.Add(AttributeChangeData.Name, AttributeChangeData.NewValue);
		OwnerCharacter.OnAttributeChanged(AttributeChangeData);
	}

	float32 GetAttributeValue(FName AttributeName)
	{
		if (!CachedAttributeValues.Contains(AttributeName)) {
			CachedAttributeValues.Add(AttributeName, AttributeSet.GetAttribute(AttributeName).GetCurrentValue());
		}
		return CachedAttributeValues[AttributeName];
	}

	// TODO: 这样直接设置不生效，不会回调到OnAttributeChanged里，导致即使最简单的对一级属性的加减，也要通过GE来实现，调查下原因
	// void SetAttributeValue(FName AttributeName, float32 Value)
	// {
	// 	FAngelscriptGameplayAttributeData& AttributeData = AttributeSet.GetAttribute(AttributeName);
	// 	AttributeData.SetBaseValue(Value);
	// 	AttributeData.SetCurrentValue(Value);
	// }

	// void AddAttributeValue(FName AttributeName, float32 Value)
	// {
	// 	FAngelscriptGameplayAttributeData& AttributeData = AttributeSet.GetAttribute(AttributeName);
	// 	AttributeData.SetBaseValue(AttributeData.GetBaseValue() + Value);
	// 	AttributeData.SetCurrentValue(AttributeData.GetCurrentValue() + Value);
	// }
}