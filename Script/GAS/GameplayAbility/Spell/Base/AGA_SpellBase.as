
class UAGA_SpellBase : UAuraGameplayAbility {
	// -------------------- Properties --------------------
	UPROPERTY(Category = "Aura")
	UAnimMontage AnimMontage;

	UPROPERTY(Category = "Aura")
	FGameplayTag EventTag;

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
	}

	UFUNCTION()
	protected void OnGameplayEventReceived(FGameplayEventData Payload) {// virtual empty
		AAuraCharacterBase OwnerCharacter = GetOwnerCharacter();
		if (OwnerCharacter != nullptr) {
			FVector SourceLocation = OwnerCharacter.GetWeaponSocketLocation();
			const FVector& TargetLocation = OwnerCharacter.GetAttackTargetLocation();
			FRotator Rotation = (TargetLocation - SourceLocation).Rotation();
			Rotation.Pitch = 0.f;

			if (CastSpell(OwnerCharacter, SourceLocation, Rotation)) {
				OwnerCharacter.SetFacingTarget(TargetLocation);
			}
		}

		EndAbility();
	}

	// Cast this spell, override this function to implement the spell
	protected bool CastSpell(AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) {
		return false;
	}
}
