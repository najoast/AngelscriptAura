
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	// -------------------- Const --------------------
	const float32 DISSOLVE_TIME = 2;
	const float32 RAGDOLL_TIME = 1.5;

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

	UPROPERTY()
	TSubclassOf<UWidgetComponent> DamageComponentClass;

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
		FSDataCharacter SDataCharacter = AuraUtil::GetSDataMgr().CharacterMap[CharacterID];
		return SDataCharacter.HitReactMontage;
		// if (IsDead()) {
		// 	return SDataCharacter.DeathMontage;
		// } else {
		// 	return SDataCharacter.HitReactMontage;
		// }
	}

	void BeHit(AActor Attacker, float32 IncomingDamage)
	{
		ShowDamageNumber(IncomingDamage);
		TryPlayHitReactMontage();
	}

	void TryPlayHitReactMontage()
	{
		FGameplayAbilitySpec OutSpec;
		if (AbilitySystem.FindAbilitySpecFromClass(UAGA_HitReact, OutSpec)) {
			if (!OutSpec.IsActive()) {
				AbilitySystem.TryActivateAbility(OutSpec.Handle);
			}
		}
	}

	bool IsDead()
	{
		return GasModule.GetAttributeValue(AuraAttributes::Health) <= 0;
	}

	void Die()
	{
		// Ragdoll Die
		Weapon.DetachFromComponent(EDetachmentRule::KeepWorld, EDetachmentRule::KeepWorld, EDetachmentRule::KeepWorld, true);
		AuraUtil::RagdollComponent(Weapon);
		AuraUtil::RagdollComponent(Mesh);
		CapsuleComponent.SetCollisionEnabled(ECollisionEnabled::NoCollision);

		// LifeSpan
		SetLifeSpan(RAGDOLL_TIME + DISSOLVE_TIME);

		System::SetTimer(this, n"Dissolve", RAGDOLL_TIME, false);
	}

	UFUNCTION()
	private void Dissolve()
	{
		FSDataCharacter SDataCharacter = AuraUtil::GetSDataMgr().CharacterMap[CharacterID];
		if (System::IsValid(SDataCharacter.DissolveMaterial)) {
			UMaterialInstanceDynamic MID_Dissolve = Material::CreateDynamicMaterialInstance(SDataCharacter.DissolveMaterial);
			Mesh.SetMaterial(0, MID_Dissolve);

			AuraUtil::GameInstance().TickerMgr.CreateTicker(DISSOLVE_TIME, FTickerDelegate(this, n"DissolveTick"), ETickerFuncType::BodyDissolve);
		}
		if (System::IsValid(SDataCharacter.WeaponDissolveMaterial)) {
			UMaterialInstanceDynamic MID_WeaponDissolve = Material::CreateDynamicMaterialInstance(SDataCharacter.WeaponDissolveMaterial);
			Weapon.SetMaterial(0, MID_WeaponDissolve);

			AuraUtil::GameInstance().TickerMgr.CreateTicker(DISSOLVE_TIME, FTickerDelegate(this, n"DissolveTick"), ETickerFuncType::WeaponDissolve);
		}
	}

	UFUNCTION()
	private void DissolveTick(float DeltaTime, float Percent, ETickerFuncType FuncType, TArray<UObject> Params)
	{
		if (FuncType == ETickerFuncType::BodyDissolve) {
			Mesh.SetScalarParameterValueOnMaterials(n"Dissolve", Percent);
		} else if (FuncType == ETickerFuncType::WeaponDissolve) {
			Weapon.SetScalarParameterValueOnMaterials(n"Dissolve", Percent);
		}
	}

	void ShowDamageNumber(float DamageAmount, FLinearColor DamageColor = FLinearColor::White)
	{
		// AUW_FloatText
		// TSubclassOf<UUserWidget> WidgetClass = SDataUtil::GetWidgetClass(n"FloatText");
		// UUserWidget UserWidget = WidgetBlueprint::CreateWidget(WidgetClass, GetLocalViewingPlayerController());
		// UAUW_FloatText AUW_FloatText = Cast<UAUW_FloatText>(UserWidget);
		// if (AUW_FloatText == nullptr) {
		// 	Print(f"Failed to create UserWidget {WidgetClass}");
		// 	return;
		// }
		// AUW_FloatText.Text_FloatText.SetText(FText::AsNumber(DamageAmount, FNumberFormattingOptions()));
		// AUW_FloatText.Text_FloatText.SetColorAndOpacity(DamageColor);

		// UWidgetComponent DamageComponent = NewObject(this, UWidgetComponent);
		UWidgetComponent DamageComponent = this.CreateComponent(DamageComponentClass);
		UAUW_FloatText AUW_FloatText = Cast<UAUW_FloatText>(DamageComponent.GetWidget());
		if (AUW_FloatText == nullptr) {
			return;
		}

		AUW_FloatText.Ctor(this);
		AUW_FloatText.OwnerWidgetComponent = DamageComponent;
		AUW_FloatText.Text_FloatText.SetText(FText::AsNumber(DamageAmount, FNumberFormattingOptions()));
		AUW_FloatText.Text_FloatText.SetColorAndOpacity(DamageColor);

		DamageComponent.AttachToComponent(GetRootComponent(), NAME_None, EAttachmentRule::KeepRelative);
		DamageComponent.DetachFromComponent(EDetachmentRule::KeepWorld);
	}
}
