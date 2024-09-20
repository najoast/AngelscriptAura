// 注: 这个 GA 是挂到受击人自己身上的

class UAGA_HitReact : UAuraGameplayAbility
{
	// -------------------- Properties --------------------

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		AAuraCharacterBase AvatarActor = Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
		// TODO: 限制移动

		// 被击中后，播放受击动画，限制移动，动画播放完毕后，再恢复移动
		UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, NAME_None, AvatarActor.GetHitReactMontage());
		MontagePlayTask.OnCompleted.AddUFunction(this, n"OnHitReactMontageCompleted");
		MontagePlayTask.ReadyForActivation();
	}

	UFUNCTION()
	private void OnHitReactMontageCompleted()
	{
		Print("OnHitReactMontageCompleted");
		EndAbility();
	}
}
