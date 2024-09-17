
class UAuraUserWidget : UUserWidget
{
	AAuraCharacterBase OwnerCharacter;

	void Ctor(AAuraCharacterBase InCharacter)
	{
		OwnerCharacter = InCharacter;
		OnCtor();
	}

	void OnCtor()
	{
	}

	APlayerController GetPlayerController()
	{
		return OwnerCharacter.GetLocalViewingPlayerController();
	}

	APlayerState GetPlayerState()
	{
		return OwnerCharacter.PlayerState;
	}

	UAngelscriptAbilitySystemComponent GetAbilitySystemComponent()
	{
		return OwnerCharacter.AbilitySystem;
	}
}