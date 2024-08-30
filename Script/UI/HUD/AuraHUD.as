
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

	UOverlayWidgetController GetOverlayWidgetController(const FWidgetControllerParams& WCParams)
	{
		if (OverlayWidgetController == nullptr)
		{
			OverlayWidgetController = NewObject(this, OverlayWidgetControllerClass);
			OverlayWidgetController.SetWidgetControllerParams(WCParams);
		}
		return OverlayWidgetController;
	}

	void InitOverlay(APlayerController PC, APlayerState PS, UAngelscriptAbilitySystemComponent ASC, UAuraAttributeSet AS)
	{
		check(OverlayWidgetClass != nullptr);
		check(OverlayWidgetControllerClass != nullptr);

		UUserWidget Widget = WidgetBlueprint::CreateWidget(OverlayWidgetClass, OwningPlayerController);
		OverlayWidget = Cast<UAuraUserWidget>(Widget);

		const FWidgetControllerParams WCParams(PC, PS, ASC, AS);
		OverlayWidget.SetWidgetController(GetOverlayWidgetController(WCParams));

		Widget.AddToViewport();
	}
}