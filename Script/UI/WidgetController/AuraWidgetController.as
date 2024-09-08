
class UAuraWidgetController : UObject
{
	AAuraCharacter Character;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	APlayerController PlayerController;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	APlayerState PlayerState;

	// The owner's ASC of this controller (Player)
	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	UAngelscriptAbilitySystemComponent AbilitySystemComponent;

	UPROPERTY(BlueprintReadOnly, Category = "WidgetController")
	UAuraAttributeSet AttributeSet;

	UFUNCTION()
	void Init(AAuraCharacter InCharacter)
	{
		Character = InCharacter;
		PlayerController = InCharacter.GetLocalViewingPlayerController();
		PlayerState = InCharacter.PlayerState;
		AbilitySystemComponent = InCharacter.AbilitySystem;
		AttributeSet = Cast<UAuraAttributeSet>(AbilitySystemComponent.RegisterAttributeSet(UAuraAttributeSet::StaticClass()));

		OnWidgetControllerParamsSet();
	}

	void OnWidgetControllerParamsSet()
	{
	}
}