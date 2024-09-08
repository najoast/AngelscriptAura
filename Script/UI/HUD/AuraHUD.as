
class AAuraHUD : AHUD
{
	UPROPERTY(NotEditable)
	UAuraUserWidget OverlayWidget;

	UPROPERTY()
	TSubclassOf<UAuraUserWidget> OverlayWidgetClass;

	UPROPERTY(NotEditable)
	UOverlayWidgetController OverlayWidgetController;

	UPROPERTY()
	TSubclassOf<UOverlayWidgetController> OverlayWidgetControllerClass;

	UOverlayWidgetController GetOverlayWidgetController(AAuraCharacter Character)
	{
		if (OverlayWidgetController == nullptr)
		{
			OverlayWidgetController = NewObject(this, OverlayWidgetControllerClass);
			OverlayWidgetController.Init(Character);
		}
		return OverlayWidgetController;
	}

	void InitOverlay(AAuraCharacter Character)
	{
		check(OverlayWidgetClass != nullptr);
		check(OverlayWidgetControllerClass != nullptr);

		UUserWidget Widget = WidgetBlueprint::CreateWidget(OverlayWidgetClass, OwningPlayerController);
		OverlayWidget = Cast<UAuraUserWidget>(Widget);
		OverlayWidget.SetWidgetController(GetOverlayWidgetController(Character));
		Widget.AddToViewport();
	}
}