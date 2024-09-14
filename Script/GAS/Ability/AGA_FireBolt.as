
class UAGA_FireBolt : UAuraGameplayAbility
{
	UPROPERTY()
	TSubclassOf<AAuraProjectile> ProjectileClass;

	UPROPERTY()
	UAnimMontage AM_FireBolt;

	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		auto MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"FireBolt", AM_FireBolt);
		// MontagePlayTask.OnCompleted.AddUFunction(this, n"OnFireBoltMontageCompleted");
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, GameplayTags::Event_Montage_FireBolt);
		WaitGameplayEvent.EventReceived.AddUFunction(this, n"SpawnFireBoltProjectile");
		WaitGameplayEvent.ReadyForActivation();

		System::SetTimer(this, n"TimeoutEndAbility", 0.5, false);
	}

	UFUNCTION()
	private void SpawnFireBoltProjectile(FGameplayEventData Payload)
	{
		AAuraCharacterBase AvatarActor = Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
		if (AvatarActor != nullptr) {
			AActor ProjectileActor = SpawnActor(ProjectileClass, AvatarActor.GetWeaponSocketLocation(), FRotator::ZeroRotator, n"FireBolt", true);
			if (ProjectileActor != nullptr) {
				FinishSpawningActor(ProjectileActor);
			}
		}
	}

	UFUNCTION()
	private void TimeoutEndAbility()
	{
		EndAbility();
	}
}