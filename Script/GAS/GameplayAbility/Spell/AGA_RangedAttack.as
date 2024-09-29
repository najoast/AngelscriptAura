
class UAGA_RangedAttack : UAGA_SpellBase {
	UPROPERTY()
	TSubclassOf<AAuraProjectile> ProjectileClass;

	bool CastSpell(FGameplayEventData Payload, AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
		// Spawn the projectile
		AAuraProjectile ProjectileActor = Cast<AAuraProjectile>(SpawnActor(ProjectileClass, SourceLocation, Rotation, n"AuraProjectile", true));
		if (ProjectileActor == nullptr) {
			return false;
		}
		FGameplayEffectSpecHandle SpecHandle = GasUtil::MakeGameplayEffectSpecHandle(OwnerCharacter, DamageEffectClass, GetAbilityLevel());
		// SpecHandle.GetSpec().SetByCallerMagnitude(GameplayTags::Damage, 30);
		ProjectileActor.DamageEffectSpecHandle = SpecHandle;
		FinishSpawningActor(ProjectileActor);
		return true;
	}
}
