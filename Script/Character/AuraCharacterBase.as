
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	default bReplicates = true;

	UPROPERTY(DefaultComponent, Category = "Combat", Attach = "CharacterMesh0", AttachSocket = "WeaponHandSocket")
	USkeletalMeshComponent Weapon;
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	// Name of weapon tip socket
	UPROPERTY(Category = "Combat")
	FName WeaponTipSocketName = AuraConst::DefaultWeaponTipSocketName;

	UPROPERTY(Category = "GAS")
	TArray<TSubclassOf<UGameplayEffect>> InitAppliedEffects;

	UPROPERTY(Category = "GAS")
	TArray<TSubclassOf<UGameplayAbility>> InitAddedAbilities;

	UFUNCTION(BlueprintOverride)
	void BeginPlay() {
		for (auto EffectClass : InitAppliedEffects) {
			GasUtil::ApplyGameplayEffect(this, this, EffectClass);
		}

		for (auto AbilityClass : InitAddedAbilities) {
			FGameplayAbilitySpecHandle Handle = GasUtil::GiveAbility(this, AbilityClass);
		}
	}

	FVector GetWeaponSocketLocation() {
		return Weapon.GetSocketLocation(WeaponTipSocketName);
	}
}
