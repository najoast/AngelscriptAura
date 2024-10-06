// Character class config
USTRUCT()
struct FSDataCharacterClass {
	UPROPERTY()
	ECharacterClass CharacterClass;

	UPROPERTY()
	TArray<TSubclassOf<UGameplayEffect>> AttributeEffects;
}
