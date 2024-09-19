
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	// -------------------- Properties --------------------
	default bReplicates = true;
	default CapsuleComponent.SetCollisionResponseToChannel(ECollisionChannel::ECC_Camera, ECollisionResponse::ECR_Ignore);
	// Do not set collision on mesh, keep default collision. (Only use CapsuleComponent for collision)
	// default Mesh.SetCollisionEnabled(ECollisionEnabled::NoCollision);
	// default Mesh.SetCollisionResponseToChannel(ECollisionChannel::ECC_Camera, ECollisionResponse::ECR_Ignore);

	UPROPERTY(DefaultComponent, Category = "Combat", Attach = "CharacterMesh0", AttachSocket = "WeaponHandSocket")
	USkeletalMeshComponent Weapon;
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	// Name of weapon tip socket
	UPROPERTY(Category = "Combat")
	FName WeaponTipSocketName = AuraConst::DefaultWeaponTipSocketName;

	UPROPERTY(Category = "GAS")
	TArray<TSubclassOf<UGameplayAbility>> InitAddedAbilities;

	// TODO: 职业先放在这里，后面交给玩家选择
	UPROPERTY()
	ECharacterClass CharacterClass = ECharacterClass::Mage;

	// -------------------- Varibles --------------------
	UGasModule GasModule;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		GasModule = Cast<UGasModule>(NewObject(this, UGasModule::StaticClass(), n"UGasModule"));
		GasModule.Init(this);

		FSDataCharacterClass SDataCharacterClass = AuraUtil::GetSDataMgr().CharacterClassMap[CharacterClass];
		if (SDataCharacterClass.AttributeEffects.Num() > 0) {
			for (auto EffectClass : SDataCharacterClass.AttributeEffects) {
				GasUtil::ApplyGameplayEffect(this, this, EffectClass);
			}
		}

		for (auto AbilityClass : InitAddedAbilities) {
			FGameplayAbilitySpecHandle Handle = GasUtil::GiveAbility(this, AbilityClass);
		}
	}

	FVector GetWeaponSocketLocation()
	{
		return Weapon.GetSocketLocation(WeaponTipSocketName);
	}

	void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{// virtual empty
	}
}
