class UAuraWidgetController : UObject
{
	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	APlayerController PlayerController;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	APlayerState PlayerState;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	UAbilitySystemComponent AbilitySystemComponent;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	UAttributeSet AttributeSet;
}