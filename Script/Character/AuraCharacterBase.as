
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	UPROPERTY(DefaultComponent, Category = "Combat", Attach = "CharacterMesh0", AttachSocket = "WeaponHandSocket")
	USkeletalMeshComponent Weapon;
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	UPROPERTY(Category = "Attributes")
	TArray<TSubclassOf<UGameplayEffect>> InitAppliedEffects;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		for (auto EffectClass : InitAppliedEffects)
		{
			AuraUtil::ApplyGameplayEffect(this, this, EffectClass);
		}
	}
}
