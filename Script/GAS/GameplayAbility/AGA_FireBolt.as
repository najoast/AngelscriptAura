
class UAGA_FireBolt : UAGA_SpellBase
{
	UPROPERTY(Category = "Aura")
	TSubclassOf<AAuraProjectile> ProjectileClass;

	UPROPERTY(Category = "Aura")
	TSubclassOf<UGameplayEffect> DamageEffectClass;

	protected void OnGameplayEventReceived(FGameplayEventData Payload) override
	{
		AAuraCharacterBase AvatarActor = Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
		if (AvatarActor != nullptr) {
			FVector SourceLocation = AvatarActor.GetWeaponSocketLocation();
			FRotator Rotation = (TargetLocation - SourceLocation).Rotation();
			Rotation.Pitch = 0.f;

			// Spawn the projectile
			AAuraProjectile ProjectileActor = Cast<AAuraProjectile>(SpawnActor(ProjectileClass, SourceLocation, Rotation, n"FireBolt", true));
			if (ProjectileActor != nullptr) {
				FGameplayEffectSpecHandle SpecHandle = GasUtil::MakeGameplayEffectSpecHandle(AvatarActor, DamageEffectClass, GetAbilityLevel());
				// SpecHandle.GetSpec().SetByCallerTagMagnitudes.Add(GameplayTags::Damage, 30);
				SpecHandle.GetSpec().SetByCallerMagnitude(GameplayTags::Damage, 30);
				ProjectileActor.DamageEffectSpecHandle = SpecHandle;
				FinishSpawningActor(ProjectileActor);
			}

			// Set the facing target
			AvatarActor.SetFacingTarget(TargetLocation);
		}
		EndAbility();
	}
}
