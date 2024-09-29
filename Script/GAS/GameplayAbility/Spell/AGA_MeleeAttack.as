
class UAGA_MeleeAttack : UAGA_EnemySpell {
	UPROPERTY()
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	void OnGameplayEventReceived(FGameplayEventData Payload) override {
		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Black, 0.5);
	}
}
