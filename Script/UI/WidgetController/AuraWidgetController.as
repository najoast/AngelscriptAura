struct FWidgetControllerParams
{
	APlayerController PlayerController;
	APlayerState PlayerState;
	UAngelscriptAbilitySystemComponent AbilitySystemComponent;
	UAuraAttributeSet AttributeSet;

	FWidgetControllerParams() {}
	FWidgetControllerParams(APlayerController InPlayerController, APlayerState InPlayerState, UAngelscriptAbilitySystemComponent InAbilitySystemComponent, UAuraAttributeSet InAttributeSet)
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
	UAngelscriptAbilitySystemComponent AbilitySystemComponent;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	UAuraAttributeSet AttributeSet;

	UFUNCTION()
	void SetWidgetControllerParams(const FWidgetControllerParams& Params)
	{
		PlayerController = Params.PlayerController;
		PlayerState = Params.PlayerState;
		AbilitySystemComponent = Params.AbilitySystemComponent;
		AttributeSet = Params.AttributeSet;
	}
}