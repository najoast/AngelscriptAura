
struct FEffectProperties
{
	FGameplayEffectContextHandle EffectContextHandle;

	UPROPERTY()
	UAbilitySystemComponent SourceASC = nullptr;

	UPROPERTY()
	AActor SourceAvatarActor = nullptr;

	UPROPERTY()
	AController SourceController = nullptr;

	UPROPERTY()
	ACharacter SourceCharacter = nullptr;

	UPROPERTY()
	UAbilitySystemComponent TargetASC = nullptr;

	UPROPERTY()
	AActor TargetAvatarActor = nullptr;

	UPROPERTY()
	AController TargetController = nullptr;

	UPROPERTY()
	ACharacter TargetCharacter = nullptr;
}
