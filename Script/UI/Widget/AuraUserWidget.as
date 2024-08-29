
class UAuraUserWidget : UUserWidget
{
	UPROPERTY(BlueprintReadOnly, Category = "UserWidget")
	UObject WidgetController;

	void SetWidgetController(UObject InWidgetController)
	{
		WidgetController = InWidgetController;
	}
}