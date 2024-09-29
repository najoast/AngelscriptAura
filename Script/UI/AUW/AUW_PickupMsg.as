
class UAUW_PickupMsg : UAuraUserWidget {
	UPROPERTY(BindWidget)
	UImage Image_Icon;

	UPROPERTY(BindWidget)
	UTextBlock TextBox_Msg;

	UPROPERTY(Transient, Meta = (BindWidgetAnim), NotEditable)
	protected UWidgetAnimation Anim_FadeExit;

	void OnCtor() override {
		if (Anim_FadeExit != nullptr) {
			PlayAnimation(Anim_FadeExit);
		}
	}

	UFUNCTION(BlueprintOverride)
	void OnAnimationFinished(const UWidgetAnimation Animation) {
		if (Animation == Anim_FadeExit) {
			RemoveFromParent();
		}
	}

	// UFUNCTION(BlueprintOverride)
	// void Tick(FGeometry MyGeometry, float InDeltaTime)
	// {
	// 	Print("Tick:" + TextBox_Msg.GetText().ToString());
	// }
}