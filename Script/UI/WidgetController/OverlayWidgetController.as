
class UOverlayWidgetController : UAuraWidgetController
{
	void OnWidgetControllerParamsSet(const FWidgetControllerParams& Params) override
	{
		Super::OnWidgetControllerParamsSet(Params);
		Print("OnWidgetControllerParamsSet");
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
}