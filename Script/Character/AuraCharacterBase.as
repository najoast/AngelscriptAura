
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	UPROPERTY(DefaultComponent, Category = "Combat", Attach = "CharacterMesh0", AttachSocket = "WeaponHandSocket")
	USkeletalMeshComponent Weapon;
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		// This is how we register an attribute set with an actor.
		AbilitySystem.RegisterAttributeSet(UAuraPlayerAttributeSet::StaticClass());
		AbilitySystem.InitAbilityActorInfo(this, this);	
	}
}
