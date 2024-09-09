
class AAuraHUD : AHUD
{
	UPROPERTY(NotEditable)
	UAuraUserWidget OverlayWidget;

	UPROPERTY()
	TSubclassOf<UAuraUserWidget> HUDWidgetClass;

	void InitOverlay(AAuraCharacter Character)
	{
		check(HUDWidgetClass != nullptr);

		WidgetUtil::OpenWidgetByClass(HUDWidgetClass, Character);
	}
}