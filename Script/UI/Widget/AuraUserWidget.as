
class UAuraUserWidget : UUserWidget
{
	UPROPERTY(BlueprintReadOnly, Category = "UserWidget")
	UAuraWidgetController WidgetController;

	void SetWidgetController(UAuraWidgetController InWidgetController)
	{
		WidgetController = InWidgetController;
		OnWidgetControllerSet();
	}

	void OnWidgetControllerSet()
	{
	}
}