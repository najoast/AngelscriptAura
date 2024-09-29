
struct FEffectProperties {
	FGameplayEffectContextHandle EffectContextHandle;

	UPROPERTY()
	UAngelscriptAbilitySystemComponent SourceASC = nullptr;

	UPROPERTY()
	AActor SourceAvatarActor = nullptr;

	UPROPERTY()
	AController SourceController = nullptr;

	UPROPERTY()
	ACharacter SourceCharacter = nullptr;

	UPROPERTY()
	UAngelscriptAbilitySystemComponent TargetASC = nullptr;

	UPROPERTY()
	AActor TargetAvatarActor = nullptr;

	UPROPERTY()
	AController TargetController = nullptr;

	UPROPERTY()
	ACharacter TargetCharacter = nullptr;
}
