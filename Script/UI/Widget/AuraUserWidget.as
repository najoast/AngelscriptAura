
class UAuraUserWidget : UUserWidget
{
	AAuraCharacter Character;

	void Ctor(AAuraCharacter InCharacter)
	{
		Character = InCharacter;
		OnCtor();
	}

	void OnCtor()
	{
	}

	APlayerController GetPlayerController()
	{
		return Character.GetLocalViewingPlayerController();
	}

	APlayerState GetPlayerState()
	{
		return Character.PlayerState;
	}

	UAngelscriptAbilitySystemComponent GetAbilitySystemComponent()
	{
		return Character.AbilitySystem;
	}
}