
class AAuraProjectile : AActor
{
	// -------------------- Properties --------------------
	default bReplicates = true;

	UPROPERTY(DefaultComponent, RootComponent)
	USceneComponent SceneRoot;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	USphereComponent Sphere;
	default Sphere.SetCollisionEnabled(ECollisionEnabled::QueryOnly);
	default Sphere.SetCollisionObjectType(AuraEnum::ECC_Projectile);
	default Sphere.SetCollisionResponseToAllChannels(ECollisionResponse::ECR_Ignore);
	default Sphere.SetCollisionResponseToChannel(ECollisionChannel::ECC_WorldDynamic, ECollisionResponse::ECR_Overlap);
	default Sphere.SetCollisionResponseToChannel(ECollisionChannel::ECC_WorldStatic, ECollisionResponse::ECR_Overlap);
	default Sphere.SetCollisionResponseToChannel(ECollisionChannel::ECC_Pawn, ECollisionResponse::ECR_Overlap);

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	UNiagaraComponent NiagaraComponent;

	UPROPERTY(DefaultComponent)
	UProjectileMovementComponent ProjectileMovement;
	default ProjectileMovement.InitialSpeed = AuraConst::ProjectileMaxSpeed;
	default ProjectileMovement.MaxSpeed = AuraConst::ProjectileMaxSpeed;
	default ProjectileMovement.ProjectileGravityScale = 0;

	UPROPERTY()
	UNiagaraSystem ImpactEffect;

	UPROPERTY()
	USoundBase ImpactSound;

	UPROPERTY()
	USoundBase LoopingSound;

	UPROPERTY()
	UAudioComponent LoopingSoundComponent;

	// -------------------- Varibles --------------------
	FGameplayEffectSpecHandle DamageEffectSpecHandle;

	// -------------------- Functions --------------------
	UFUNCTION(BlueprintOverride)
	void EndPlay(EEndPlayReason EndPlayReason)
	{
		if (LoopingSoundComponent != nullptr) {
			LoopingSoundComponent.Stop();
		}
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		LoopingSoundComponent = Gameplay::SpawnSoundAttached(LoopingSound, GetRootComponent());
		check(LoopingSoundComponent != nullptr);
		SetLifeSpan(AuraConst::ProjectileLifeSpan);
	}

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		// Print("Overlapping with: " + OtherActor.Name);
		Gameplay::PlaySoundAtLocation(ImpactSound, GetActorLocation(), GetActorRotation());
		Niagara::SpawnSystemAtLocation(ImpactEffect, GetActorLocation(), GetActorRotation());

		if (DamageEffectSpecHandle.IsValid()) {
			UAbilitySystemComponent TargetASC = AbilitySystem::GetAbilitySystemComponent(OtherActor);
			if (TargetASC != nullptr) {
				TargetASC.ApplyGameplayEffectSpecToSelf(DamageEffectSpecHandle);
			}
		}

		DestroyActor();
	}
}
