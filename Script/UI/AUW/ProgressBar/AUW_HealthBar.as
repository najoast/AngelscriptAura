
class UAUW_HealthBar : UAuraUserWidget
{
	// -------------------- Properties --------------------
	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Ghost;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Main;

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
	}

	UFUNCTION(BlueprintOverride)
	void Tick(FGeometry MyGeometry, float InDeltaTime)
	{
		GhostPrograssModule.Tick(MyGeometry, InDeltaTime);
	}
}
