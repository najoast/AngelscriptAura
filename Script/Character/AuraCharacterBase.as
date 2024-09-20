
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

	UPROPERTY()
	uint16 CharacterID;

	// -------------------- Varibles --------------------
	UGasModule GasModule;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		check(CharacterID != 0);
		auto CharacterMap = AuraUtil::GetSDataMgr().CharacterMap;
		check(CharacterMap.Contains(CharacterID));

		FSDataCharacter SDataCharacter = CharacterMap[CharacterID];
		ECharacterClass CharacterClass = SDataCharacter.CharacterClass;

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

		// 玩家和怪物都有的一些 Ability // TODO: 移到 GlobalConfig 里去
		GasUtil::GiveAbility(this, UAGA_HitReact);
	}

	FVector GetWeaponSocketLocation()
	{
		return Weapon.GetSocketLocation(WeaponTipSocketName);
	}

	void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData)
	{// virtual empty
	}

	UAnimMontage GetHitReactMontage()
	{
		return AuraUtil::GetSDataMgr().CharacterMap[CharacterID].HitReactMontage;
	}

	void PlayHitReactMontage()
	{
		FGameplayAbilitySpec OutSpec;
		if (AbilitySystem.FindAbilitySpecFromClass(UAGA_HitReact, OutSpec)) {
			if (!OutSpec.IsActive()) {
				AbilitySystem.TryActivateAbility(OutSpec.Handle);
			}
		}
	}
}
