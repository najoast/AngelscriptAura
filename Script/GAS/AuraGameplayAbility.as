
class UAuraGameplayAbility : UAngelscriptGASAbility {
	AAuraCharacterBase GetOwnerCharacter() {
		return Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
	}
}
