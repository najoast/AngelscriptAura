
class UOverlayWidgetController : UAuraWidgetController
{
	void OnWidgetControllerParamsSet(const FWidgetControllerParams& Params) override
	{
		Super::OnWidgetControllerParamsSet(Params);
		Print("OnWidgetControllerParamsSet");
		AttributeSet.OnGameplayEffectAppliedEvent.AddUFunction(this, n"OnGameplayEffectApplied");

		RegisterAllWidgetsEvent();
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

	void RegisterAllWidgetsEvent()
	{
		auto EventMgr = UAuraGameInstanceSubsystem::Get().EventMgr;
		EventMgr.OnItemPickedUpEvent.AddUFunction(this, n"OnItemPickedUp");
	}

	UFUNCTION()
	void OnItemPickedUp(EItemID ItemID)
	{
		FSDataItem Item = SData::GetItem(ItemID);
		if (Item.ID == EItemID::None) {
			Print(f"Item {ItemID} is not found");
			return;
		}
		// UAUW_PickupMsg AUW_PickupMsg = Cast<UAUW_PickupMsg>(LoadObject(this, "/Game/Blueprints/UI/WBP_PickupMsg"));
		TSubclassOf<UUserWidget> WidgetClass = SData::GetWidgetClass(n"PickupMsg");
		UAUW_PickupMsg AUW_PickupMsg = Cast<UAUW_PickupMsg>(WidgetBlueprint::CreateWidget(WidgetClass, PlayerController));
		if (AUW_PickupMsg == nullptr) {
			Print(f"Failed to create AUW_PickupMsg");
			return;
		}
		AUW_PickupMsg.Image_Icon.SetBrushFromTexture(Item.Icon);
		FText Text = FText::FromString(f"Picked up a {Item.Name}");
		AUW_PickupMsg.TextBox_Msg.SetText(Text);
		AUW_PickupMsg.AddToViewport();
	}
}