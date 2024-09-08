
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	UPROPERTY(DefaultComponent, Category = "Combat", Attach = "CharacterMesh0", AttachSocket = "WeaponHandSocket")
	USkeletalMeshComponent Weapon;
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);
}
