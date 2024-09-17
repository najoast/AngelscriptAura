class UAUW_GlobeProgressBar : UAuraUserWidget
{
	// -------------------- Properties --------------------
	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Main;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Ghost;

	UPROPERTY(BindWidget)
	UTextBlock Text_Value;

	// -------------------- Varibles --------------------
	private UGhostPrograssModule GhostPrograssModule;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void OnInitialized()
	{
		GhostPrograssModule = Cast<UGhostPrograssModule>(NewObject(this, UGhostPrograssModule));
		GhostPrograssModule.Init(ProgressBar_Main, ProgressBar_Ghost);
	}

	void SetPercent(float32 NewValue, float32 NewMaxValue)
	{
		GhostPrograssModule.SetPercent(NewValue, NewMaxValue);
		Text_Value.SetText(FText::FromString(f"{NewValue :.0}/{NewMaxValue :.0}"));
	}

	UFUNCTION(BlueprintOverride)
	void Tick(FGeometry MyGeometry, float InDeltaTime)
	{
		GhostPrograssModule.Tick(MyGeometry, InDeltaTime);
	}

	UFUNCTION(BlueprintOverride)
	void OnMouseEnter(FGeometry MyGeometry, FPointerEvent MouseEvent)
	{
		if (!MouseEvent.GetEffectingButton().IsValid()) {
			Text_Value.SetVisibility(ESlateVisibility::Visible);
		}
	}

	UFUNCTION(BlueprintOverride)
	void OnMouseLeave(FPointerEvent MouseEvent)
	{
		if (!MouseEvent.GetEffectingButton().IsValid()) {
			Text_Value.SetVisibility(ESlateVisibility::Collapsed);
		}
	}
}
