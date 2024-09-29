
class UAGA_RangedAttack : UAGA_EnemySpell {
	bool CastSpell(AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Purple, 0.5);
		return true;
	}
}
