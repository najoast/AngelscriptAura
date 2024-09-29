
class UAGA_FireBolt : UAGA_PlayerSpell {
	UPROPERTY(Category = "Aura")
	TSubclassOf<AAuraProjectile> ProjectileClass;

	UPROPERTY(Category = "Aura")
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	bool CastSpell(AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
		// Spawn the projectile
		AAuraProjectile ProjectileActor = Cast<AAuraProjectile>(SpawnActor(ProjectileClass, SourceLocation, Rotation, n"FireBolt", true));
		if (ProjectileActor == nullptr) {
			return false;
		}
		FGameplayEffectSpecHandle SpecHandle = GasUtil::MakeGameplayEffectSpecHandle(OwnerCharacter, DamageEffectClass, GetAbilityLevel());
		// SpecHandle.GetSpec().SetByCallerTagMagnitudes.Add(GameplayTags::Damage, 30);
		SpecHandle.GetSpec().SetByCallerMagnitude(GameplayTags::Damage, 30);
		ProjectileActor.DamageEffectSpecHandle = SpecHandle;
		FinishSpawningActor(ProjectileActor);
		return true;
	}
}
