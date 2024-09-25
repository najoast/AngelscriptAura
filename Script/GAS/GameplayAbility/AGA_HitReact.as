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

		AAuraCharacterBase AvatarActor = GasUtil::GetAvatarCharacterFromAbility(this);
		// TODO: 限制移动

		if (AvatarActor.IsDead()) {
			AvatarActor.Die();
		} else {
			// 被击中后，播放受击动画，限制移动，动画播放完毕后，再恢复移动
			UAbilityTask_PlayMontageAndWait MontagePlayTask = AngelscriptAbilityTask::PlayMontageAndWait(this, NAME_None, AvatarActor.GetHitReactMontage());
			MontagePlayTask.OnBlendOut.AddUFunction(this, n"OnHitReactMontageCompleted");
			MontagePlayTask.ReadyForActivation();

			AvatarActor.AbilitySystem.AddLooseGameplayTag(GameplayTags::Effects_HitReact);
		}
	}

	UFUNCTION()
	private void OnHitReactMontageCompleted()
	{
		Print("OnHitReactMontageCompleted");
		EndAbility();

		AAuraCharacterBase AvatarActor = GasUtil::GetAvatarCharacterFromAbility(this);
		AvatarActor.AbilitySystem.RemoveLooseGameplayTag(GameplayTags::Effects_HitReact);

		// AAuraCharacterBase AvatarActor = GasUtil::GetAvatarCharacterFromAbility(this);
		// if (AvatarActor.IsDead()) {
		// 	AvatarActor.DestroyActor();
		// }
	}
}
