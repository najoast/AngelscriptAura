
class UAGA_SpellBase : UAuraGameplayAbility {
	// -------------------- Properties --------------------
	UPROPERTY()
	UAnimMontage AnimMontage;

	UPROPERTY()
	FGameplayTag EventTag;

	UPROPERTY()
	FVector TargetLocation;

	UPROPERTY()
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void ActivateAbility() {
		if (!HasAuthority()) {
			return;
		}

		UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"AnimMontage", AnimMontage);
		// Also can be triggered with OnCompleted, but this is not the effect we want. So we use AnimNotify instead.
		// MontagePlayTask.OnCompleted.AddUFunction(this, n"SpawnFireBoltProjectile");
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, EventTag);
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
