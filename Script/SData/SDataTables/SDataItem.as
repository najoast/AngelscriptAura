
USTRUCT()
struct FSDataItem
{
	// The ID of the item
	UPROPERTY()
	EItemID ID;

	// The name of the item
	UPROPERTY()
	FName Name;

	// The Icon of the item
	UPROPERTY()
	UTexture2D Icon;

	// The Gameplay Effect which will be applied when the item is used or picked up
	UPROPERTY()
	TSubclassOf<UGameplayEffect> GameplayEffectClass;
}

enum EItemID
{
	None          = 0,
	HealthPotion  = 1,
	ManaPotion    = 2,
	HealthCrystal = 3,
	ManaCrystal   = 4,
}
