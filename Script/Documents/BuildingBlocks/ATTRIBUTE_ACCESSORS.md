
C++ 里的 `ATTRIBUTE_ACCESSORS` 宏，可以给一个属性定义出4个函数，以 `Health` 为例：
```cpp
static FGameplayAttribute UMyHealthSet::GetHealthAttribute();
float UMyHealthSet::GetHealth() const;
void UMyHealthSet::SetHealth(float NewVal);
void UMyHealthSet::InitHealth(float NewVal);
```

代码如下：
```c++
#define GAMEPLAYATTRIBUTE_PROPERTY_GETTER(ClassName, PropertyName) \
	static FGameplayAttribute Get##PropertyName##Attribute() \
	{ \
		static FProperty* Prop = FindFieldChecked<FProperty>(ClassName::StaticClass(), GET_MEMBER_NAME_CHECKED(ClassName, PropertyName)); \
		return Prop; \
	}

#define GAMEPLAYATTRIBUTE_VALUE_GETTER(PropertyName) \
	FORCEINLINE float Get##PropertyName() const \
	{ \
		return PropertyName.GetCurrentValue(); \
	}

#define GAMEPLAYATTRIBUTE_VALUE_SETTER(PropertyName) \
	FORCEINLINE void Set##PropertyName(float NewVal) \
	{ \
		UAbilitySystemComponent* AbilityComp = GetOwningAbilitySystemComponent(); \
		if (ensure(AbilityComp)) \
		{ \
			AbilityComp->SetNumericAttributeBase(Get##PropertyName##Attribute(), NewVal); \
		}; \
	}

#define GAMEPLAYATTRIBUTE_VALUE_INITTER(PropertyName) \
	FORCEINLINE void Init##PropertyName(float NewVal) \
	{ \
		PropertyName.SetBaseValue(NewVal); \
		PropertyName.SetCurrentValue(NewVal); \
	}
```

几点值得注意的：
1. `Getter` 返回的是 CurrentValue
2. `Setter` 调用的是 ASC 的 `SetNumericAttributeBase`，而不是简单的 `SetBaseValue`。这是因为在修改属性时，会有很多回调需要触发，比如 `Pre/PostAttributeChange`，这个 `SetNumericAttributeBase` 就是干这个的，简单的 `SetBaseValue` 是不行的。
3. `Initter` 会同时简单的调用两个 Set 来完成属性的初始化，而不是调用 `SetNumericAttributeBase`，因为在初始化时，假定不会有回调需要触发。因此，在游戏进行过程中，是不能直接调用 `Initter` 的。

# How to use in Angelscript
- AS 没有C++里的 `ATTRIBUTE_ACCESSORS` 宏
- 没有暴露 `SetNumericAttributeBase`,
- 也没有 `FActiveGameplayEffectsContainer::SetAttributeBaseValue`, 这个函数是 `SetNumericAttributeBase` 最终调用的函数

那么如何在 AS 里来达到这个宏的等价效果呢？
首先 `Getter` 和 `Initter` 不说了，因为只是调用 `SetBaseValue` 和 `SetCurrentValue`，这个 AS 里是有的。那只有 `SetNumericAttributeBase` 这一个问题要解决了。

好在 `AngelscriptGAS` 插件已经帮我们解决了这个问题，在 `UAngelscriptAbilitySystemComponent` 类里，导出了两个接口：

.h
```c++
	// Requires the attribute to actually exist
	UFUNCTION(BlueprintCallable, Category = "Attributes")
	void SetAttributeBaseValue(TSubclassOf<UAngelscriptAttributeSet> AttributeSetClass, FName AttributeName, float NewBaseValue);

	// Use these functions when you are not sure if the attribute exists
	UFUNCTION(BlueprintCallable, Category = "Attributes")
	bool TrySetAttributeBaseValue(TSubclassOf<UAngelscriptAttributeSet> AttributeSetClass, FName AttributeName, float NewBaseValue);
```

.cpp
```c++
	void UAngelscriptAbilitySystemComponent::SetAttributeBaseValue(TSubclassOf<UAngelscriptAttributeSet> AttributeSetClass, FName AttributeName, float NewBaseValue)
	{
		ensureMsgf(TrySetAttributeBaseValue(AttributeSetClass, AttributeName, NewBaseValue), TEXT("Could not set attribute base value for attribute <%s>"), *AttributeName.ToString());
	}

	bool UAngelscriptAbilitySystemComponent::TrySetAttributeBaseValue(TSubclassOf<UAngelscriptAttributeSet> AttributeSetClass, FName AttributeName, float NewBaseValue)
	{
		FGameplayAttribute Attribute;
		const UAttributeSet* AttributeSet = GetAttributeSubobject(AttributeSetClass);
		if (AttributeSet && ensureMsgf(
			UAngelscriptAttributeSet::TryGetGameplayAttribute(AttributeSetClass, AttributeName, Attribute), 
			TEXT("Attribute <%s> doesn't exist inside the attribute set <%s>"), *AttributeName.ToString(), *AttributeSetClass->GetName()
		))
		{
			SetNumericAttributeBase(Attribute, NewBaseValue);
			return true;
		}

		return false;
	}
```

可以看到在 `TrySetAttributeBaseValue` 里，最终是调用了 `SetNumericAttributeBase` 的，问题解决。

***
Angelscript 使用示例：
```c++
void ProcessMetaAttribute(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData& EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC)
{
	if (EvaluatedData.Attribute.AttributeName == AuraAttributes::IncomingDamage) {
		float32 IncomingDamageMagnitude = EvaluatedData.GetMagnitude();
		TargetASC.SetAttributeBaseValue(this.Class, AuraAttributes::IncomingDamage, 0);
	}
}
```