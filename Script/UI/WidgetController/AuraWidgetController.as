struct FWidgetControllerParams
{
	APlayerController PlayerController;
	APlayerState PlayerState;
	UAbilitySystemComponent AbilitySystemComponent;
	UAttributeSet AttributeSet;

	FWidgetControllerParams() {}
	FWidgetControllerParams(APlayerController InPlayerController, APlayerState InPlayerState, UAbilitySystemComponent InAbilitySystemComponent, UAttributeSet InAttributeSet)
	{
		PlayerController = InPlayerController;
		PlayerState = InPlayerState;
		AbilitySystemComponent = InAbilitySystemComponent;
		AttributeSet = InAttributeSet;
	}
}

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

	UFUNCTION()
	void SetWidgetControllerParams(const FWidgetControllerParams& Params)
	{
		PlayerController = Params.PlayerController;
		PlayerState = Params.PlayerState;
		AbilitySystemComponent = Params.AbilitySystemComponent;
		AttributeSet = Params.AttributeSet;
	}
}