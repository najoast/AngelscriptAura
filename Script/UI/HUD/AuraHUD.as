
class AAuraHUD : AHUD
{
	UPROPERTY(NotEditable)
	UAuraUserWidget OverlayWidget;

	UPROPERTY()
	TSubclassOf<UAuraUserWidget> HUDWidgetClass;

	void InitHUDWidget(AAuraCharacter Character)
	{
		check(HUDWidgetClass != nullptr);
		WidgetUtil::OpenWidgetByClass(HUDWidgetClass, Character);
	}
}