
class UAGA_SpellBase : UAuraGameplayAbility {
	// -------------------- Properties --------------------
	UPROPERTY(Category = Aura)
	TMap<FGameplayTag, UAnimMontage> AttackMontageMap;

	UPROPERTY(Category = Aura)
	EAttackMontageSelectionType AttackMontageSelectionType;

	UPROPERTY(Category = Aura)
	FVector TargetLocation;

	UPROPERTY(Category = Aura)
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	// -------------------- Varibles --------------------
	TArray<FGameplayTag> AttackMontageKeys;
	TArray<UAnimMontage> AttackMontageValues;
	// TODO: Fix void GetValues(TArray<K>& OutValues) in Bind_TMap.cpp, this should be TArray<V> (Request a PR)
	// default AttackMontageMap.GetKeys(AttackMontageKeys);
	// default AttackMontageMap.GetValues(AttackMontageValues);
	int AttackMontageIndex = 0;

	// -------------------- Functions --------------------

	UAnimMontage GetNextAnimMontage() {
		if (AttackMontageValues.Num() == 0) {
			check(AttackMontageMap.Num() > 0);
			for (auto& KeyValue : AttackMontageMap) {
				AttackMontageKeys.Add(KeyValue.Key);
				AttackMontageValues.Add(KeyValue.Value);
			}
		}

		int NumOfValues = AttackMontageValues.Num();
		if (NumOfValues == 1) {
			return AttackMontageValues[0];
		}

		// Select the next montage
		int NextIndex = 0;
		switch (AttackMontageSelectionType) {
			case EAttackMontageSelectionType::Random:
				NextIndex = Math::RandRange(0, NumOfValues - 1);
				break;
			case EAttackMontageSelectionType::Iterative:
				NextIndex = (AttackMontageIndex + 1) % NumOfValues;
				break;
			default:
				check(false);
				break;
		}

		AttackMontageIndex = NextIndex;
		return AttackMontageValues[NextIndex];
	}

	FGameplayTag GetCurrentEventTag() {
		if (AttackMontageKeys.Num() == 1) {
			return AttackMontageKeys[0];
		}

		return AttackMontageKeys[AttackMontageIndex];
	}

	UFUNCTION(BlueprintOverride)
	void ActivateAbility() {
		if (!HasAuthority()) {
			return;
		}

		UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"AnimMontage", GetNextAnimMontage());
		// Also can be triggered with OnCompleted, but this is not the effect we want. So we use AnimNotify instead.
		// MontagePlayTask.OnCompleted.AddUFunction(this, n"SpawnFireBoltProjectile");
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, GetCurrentEventTag());
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
	protected void OnGameplayEventReceived(FGameplayEventData Payload) {
		AAuraCharacterBase OwnerCharacter = GetOwnerCharacter();
		if (OwnerCharacter != nullptr) {
			FVector SourceLocation = OwnerCharacter.GetWeaponSocketLocation();
			FRotator Rotation = (TargetLocation - SourceLocation).Rotation();
			Rotation.Pitch = 0.f;

			if (CastSpell(Payload, OwnerCharacter, SourceLocation, Rotation)) {
				OwnerCharacter.SetFacingTarget(TargetLocation);
			}
		}

		EndAbility();
	}

	// Cast this spell, override this function to implement the spell
	protected bool CastSpell(FGameplayEventData Payload, AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) {
		return false;
	}

	UFUNCTION()
	private void OnMouseTargetData(const FVector& Data) {
		TargetLocation = Data;
	}
}
