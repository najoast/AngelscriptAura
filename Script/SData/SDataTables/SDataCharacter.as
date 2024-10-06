// All characters' config, including player and enemy

USTRUCT()
struct FSDataCharacter {
	UPROPERTY()
	uint16 CharacterID;

	UPROPERTY()
	FName CharacterName;

	UPROPERTY()
	ECharacterClass CharacterClass;

	UPROPERTY()
	UAnimMontage HitReactMontage;

	UPROPERTY()
	UAnimMontage DeathMontage;

	UPROPERTY()
	UMaterialInstance DissolveMaterial;

	UPROPERTY()
	UMaterialInstance WeaponDissolveMaterial;

	UPROPERTY()
	TArray<TSubclassOf<UGameplayAbility>> StartupAbilities;
}
