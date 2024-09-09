
```cpp
	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		AttributeSet.OnGameplayEffectAppliedEvent.AddUFunction(this, n"OnGameplayEffectApplied");
	}

	UFUNCTION()
	void OnGameplayEffectApplied(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC)
	{
		Print("------------- OnGameplayEffectApplied -----------");
		const FGameplayTagContainer TagContainer = EffectSpec.GetAllAssetTags();
		for (const FGameplayTag Tag : TagContainer.GameplayTags) {
			Print(f"OnEffectApplied: {Tag.ToString() =}");
		}
	}
```
