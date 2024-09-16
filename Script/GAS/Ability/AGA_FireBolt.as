
class UAGA_FireBolt : UAuraGameplayAbility
{
	UPROPERTY()
	TSubclassOf<AAuraProjectile> ProjectileClass;

	UPROPERTY()
	UAnimMontage AM_FireBolt;

	private FVector TargetLocation;

	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		auto MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, n"FireBolt", AM_FireBolt);
		// MontagePlayTask.OnCompleted.AddUFunction(this, n"OnFireBoltMontageCompleted"); // 改到 AnimNotify 里触发了，这里触发效果不对
		MontagePlayTask.ReadyForActivation();

		UAbilityTask_WaitGameplayEvent WaitGameplayEvent = AngelscriptAbilityTask::WaitGameplayEvent(this, GameplayTags::Event_Montage_FireBolt);
		WaitGameplayEvent.EventReceived.AddUFunction(this, n"SpawnFireBoltProjectile");
		WaitGameplayEvent.ReadyForActivation();

		UAAT_TargetDataUnderMouse TargetDataUnderMouse = Cast<UAAT_TargetDataUnderMouse>(UAngelscriptAbilityTask::CreateAbilityTask(UAAT_TargetDataUnderMouse, this));
		TargetDataUnderMouse.OnMouseTargetData.BindUFunction(this, n"OnMouseTargetData");
		TargetDataUnderMouse.ReadyForActivation();
	}

	UFUNCTION()
	private void SpawnFireBoltProjectile(FGameplayEventData Payload)
	{
		AAuraCharacterBase AvatarActor = Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
		if (AvatarActor != nullptr) {
			FVector SourceLocation = AvatarActor.GetWeaponSocketLocation();
			FRotator Rotation = (TargetLocation - SourceLocation).Rotation();
			Rotation.Pitch = 0.f;

			AActor ProjectileActor = SpawnActor(ProjectileClass, SourceLocation, Rotation, n"FireBolt", true);
			if (ProjectileActor != nullptr) {
				FinishSpawningActor(ProjectileActor);
			}

			// AvatarActor.SetActorRotation(Rotation);
			// TODO: 解除对 AuraCharacter 的依赖, 原作者是用 C++ Interface 来解除的，但在 AS 里没有 Interface, 可以考虑把 MotionWarping 组件放到 AuraCharacterBase 里
			AAuraCharacter AuraCharacter = Cast<AAuraCharacter>(GetAvatarActorFromActorInfo());
			if (AuraCharacter != nullptr) {
				AuraCharacter.SetFacingTarget(TargetLocation);
			}
		}
		EndAbility();
	}

	UFUNCTION()
	private void OnMouseTargetData(const FVector& Data)
	{
		Print(f"OnMouseTargetData {Data}");
		TargetLocation = Data;
	}
}
