
class UAGA_MeleeAttack : UAGA_EnemySpell {
	UPROPERTY()
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	bool CastSpell(AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Black, 0.5);
		return true;
	}
}
