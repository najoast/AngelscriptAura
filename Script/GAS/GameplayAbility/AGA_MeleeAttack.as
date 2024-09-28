
class UAGA_MeleeAttack : UAuraGameplayAbility
{
	// -------------------- Properties --------------------
	UPROPERTY()
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	UPROPERTY()
	UAnimMontage AnimMontage;

	// -------------------- Varibles --------------------
	private FVector TargetLocation;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Black, 0.5);

		UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"MeleeAttack", AnimMontage);
		MontagePlayTask.ReadyForActivation();

		// UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, GameplayTags::Event_Montage_FireBolt);
		// WaitGameplayEvent.EventReceived.AddUFunction(this, n"SpawnFireBoltProjectile");
		// WaitGameplayEvent.ReadyForActivation();

		// UAAT_TargetDataUnderMouse TargetDataUnderMouse = Cast<UAAT_TargetDataUnderMouse>(UAngelscriptAbilityTask::CreateAbilityTask(UAAT_TargetDataUnderMouse, this));
		// TargetDataUnderMouse.OnMouseTargetData.BindUFunction(this, n"OnMouseTargetData");
		// TargetDataUnderMouse.ReadyForActivation();
	}
}