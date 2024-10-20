
struct FAttackCosmetic {
	UPROPERTY()
	FGameplayTag AttackMontageTag;

	UPROPERTY()
	UAnimMontage AttackMontage;

	UPROPERTY()
	USoundBase ImpactSound;
}

class UAGA_SpellBase : UAuraGameplayAbility {
	// -------------------- Properties --------------------
	UPROPERTY(Category = Aura)
	TArray<FAttackCosmetic> AttackCosmetics;

	UPROPERTY(Category = Aura)
	EAttackMontageSelectionType AttackMontageSelectionType;

	UPROPERTY(Category = Aura)
	FVector TargetLocation;

	UPROPERTY(Category = Aura)
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	default InstancingPolicy = EGameplayAbilityInstancingPolicy::InstancedPerActor;

	// -------------------- Varibles --------------------
	// TArray<FGameplayTag> AttackMontageKeys;
	// TArray<UAnimMontage> AttackMontageValues;
	// TODO: Fix void GetValues(TArray<K>& OutValues) in Bind_TMap.cpp, this should be TArray<V> (Request a PR)
	// default AttackMontageMap.GetKeys(AttackMontageKeys);
	// default AttackMontageMap.GetValues(AttackMontageValues);
	int AttackCosmeticIndex = 0;

	// -------------------- Functions --------------------

	UAnimMontage GetNextAnimMontage() {
		int NumOfCosmetics = AttackCosmetics.Num();
		if (NumOfCosmetics == 1) {
			return AttackCosmetics[0].AttackMontage;
		}

		// Select the next montage
		int NextIndex = 0;
		switch (AttackMontageSelectionType) {
			case EAttackMontageSelectionType::Random:
				NextIndex = Math::RandRange(0, NumOfCosmetics - 1);
				break;
			case EAttackMontageSelectionType::Iterative:
				NextIndex = (AttackCosmeticIndex + 1) % NumOfCosmetics;
				break;
			default:
				check(false);
				break;
		}

		AttackCosmeticIndex = NextIndex;
		return AttackCosmetics[NextIndex].AttackMontage;
	}

	FAttackCosmetic SelectNextAttackCosmetic() {
		int NumOfCosmetics = AttackCosmetics.Num();
		if (NumOfCosmetics == 1) {
			return AttackCosmetics[0];
		}

		int NextIndex = 0;
		switch (AttackMontageSelectionType) {
			case EAttackMontageSelectionType::Random:
				NextIndex = Math::RandRange(0, NumOfCosmetics - 1);
				break;
			case EAttackMontageSelectionType::Iterative:
				NextIndex = (AttackCosmeticIndex + 1) % NumOfCosmetics;
				break;
			default:
				check(false);
				break;
		}

		AttackCosmeticIndex = NextIndex;
		return AttackCosmetics[AttackCosmeticIndex];
	}

	FAttackCosmetic GetCurrentAttackCosmetic() {
		if (AttackCosmetics.Num() == 1) {
			return AttackCosmetics[0];
		}
		return AttackCosmetics[AttackCosmeticIndex];
	}

	FGameplayTag GetCurrentEventTag() {
		return GetCurrentAttackCosmetic().AttackMontageTag;
	}

	USoundBase GetCurrentImpactSound() {
		return GetCurrentAttackCosmetic().ImpactSound;
	}

	UFUNCTION(BlueprintOverride)
	void ActivateAbility() {
		if (!HasAuthority()) {
			return;
		}

		FAttackCosmetic AttackCosmetic = SelectNextAttackCosmetic();

		UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"AnimMontage", AttackCosmetic.AttackMontage);
		MontagePlayTask.OnCompleted.AddUFunction(this, n"OnMontageCompleted");
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, AttackCosmetic.AttackMontageTag);
		WaitGameplayEvent.EventReceived.AddUFunction(this, n"OnGameplayEventReceived");
		WaitGameplayEvent.ReadyForActivation();

		AActor AvatarActor = GetAvatarActorFromActorInfo();
		if (AvatarActor.IsA(AAuraCharacter)) { // Player Character
			UAAT_TargetDataUnderMouse TargetDataUnderMouse = Cast<UAAT_TargetDataUnderMouse>(UAngelscriptAbilityTask::CreateAbilityTask(UAAT_TargetDataUnderMouse, this));
			TargetDataUnderMouse.OnMouseTargetData.BindUFunction(this, n"OnMouseTargetData");
			TargetDataUnderMouse.ReadyForActivation();
		} else { // Non-Player Character
			UBlackboardComponent Blackboard = AIHelper::GetBlackboard(AvatarActor);
			AActor TargetActor = Cast<AActor>(Blackboard.GetValueAsObject(AuraConst::AI_Blackboard_Key_TargetToFollow));
			if (TargetActor != nullptr) {
				TargetLocation = TargetActor.GetActorLocation();
			}
		}
	}

	UFUNCTION()
	void OnMontageCompleted() {
		EndAbility();
	}

	UFUNCTION()
	protected void OnGameplayEventReceived(FGameplayEventData Payload) {
		AAuraCharacterBase OwnerCharacter = GetOwnerCharacter();
		if (OwnerCharacter != nullptr) {
			FVector SourceLocation = OwnerCharacter.GetSocketLocationByGameplayTag(GetCurrentEventTag());
			FRotator Rotation = (TargetLocation - SourceLocation).Rotation();
			Rotation.Pitch = 0.f;

			if (CastSpell(Payload, OwnerCharacter, SourceLocation, Rotation)) {
				USoundBase ImpactSound = GetCurrentImpactSound();
				if (ImpactSound != nullptr) {
					Gameplay::PlaySoundAtLocation(GetCurrentImpactSound(), SourceLocation, Rotation);
				}
				OwnerCharacter.SetFacingTarget(TargetLocation);
			}
		}
	}

	// Cast this spell, override this function to implement the spell
	protected bool CastSpell(FGameplayEventData Payload, AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) {
		return false;
	}

	UFUNCTION()
	private void OnMouseTargetData(const FVector& Data) {
		TargetLocation = Data;
	}

	FVector GetAttackTargetLocation(AAuraCharacterBase OwnerCharacter) {
		FGameplayTag CurrentEventTag = GetCurrentEventTag();
		if (CurrentEventTag == GameplayTags::Montage_Attack_Weapon) {
			return OwnerCharacter.Weapon.GetSocketLocation(AuraConst::SocketName_WeaponTip);
		} else if (CurrentEventTag == GameplayTags::Montage_Attack_LeftHand) {
			return OwnerCharacter.Mesh.GetSocketLocation(AuraConst::SocketName_LeftHand);
		} else if (CurrentEventTag == GameplayTags::Montage_Attack_RightHand) {
			return OwnerCharacter.Mesh.GetSocketLocation(AuraConst::SocketName_RightHand);
		}
		return FVector::ZeroVector;
	}
}
