
class UAUW_PickupMsg : UAuraUserWidget
{
	UPROPERTY(BindWidget)
	UImage Image_Icon;

	UPROPERTY(BindWidget)
	UTextBlock TextBox_Msg;

	// UFUNCTION(BlueprintOverride)
	// void Tick(FGeometry MyGeometry, float InDeltaTime)
	// {
	// 	Print("Tick:" + TextBox_Msg.GetText().ToString());
	// }
}