
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
}
