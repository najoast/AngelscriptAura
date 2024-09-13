
class UAGA_FireBolt : UAuraGameplayAbility
{
	UPROPERTY()
	TSubclassOf<AAuraProjectile> ProjectileClass;

	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		if (!HasAuthority()) {
			return;
		}

		AAuraCharacterBase AvatarActor = Cast<AAuraCharacterBase>(GetAvatarActorFromActorInfo());
		check(AvatarActor != nullptr);

		// Spawn a projectile
		AActor ProjectileActor = SpawnActor(ProjectileClass, AvatarActor.GetWeaponSocketLocation(), FRotator::ZeroRotator, n"FireBolt", true);
		if (ProjectileActor != nullptr) {
			FinishSpawningActor(ProjectileActor);
		}
	}
}