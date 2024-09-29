USTRUCT()
struct FSDataInput {
	UPROPERTY()
	UInputAction InputAction;

	UPROPERTY()
	FGameplayTag GameplayTag;

	UPROPERTY()
	TSubclassOf<UGameplayAbility> AbilityClass;
}
