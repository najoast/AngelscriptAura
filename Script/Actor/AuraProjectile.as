
class AAuraProjectile : AActor
{
	default bReplicates = true;

	UPROPERTY(DefaultComponent, RootComponent)
	USceneComponent SceneRoot;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	USphereComponent Sphere;
	default Sphere.SetCollisionEnabled(ECollisionEnabled::QueryOnly);
	default Sphere.SetCollisionResponseToAllChannels(ECollisionResponse::ECR_Ignore);
	default Sphere.SetCollisionResponseToChannel(ECollisionChannel::ECC_WorldDynamic, ECollisionResponse::ECR_Overlap);
	default Sphere.SetCollisionResponseToChannel(ECollisionChannel::ECC_WorldStatic, ECollisionResponse::ECR_Overlap);
	default Sphere.SetCollisionResponseToChannel(ECollisionChannel::ECC_Pawn, ECollisionResponse::ECR_Overlap);

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	UNiagaraComponent NiagaraComponent;

	UPROPERTY(DefaultComponent)
	UProjectileMovementComponent ProjectileMovement;
	default ProjectileMovement.InitialSpeed = 550;
	default ProjectileMovement.MaxSpeed = 550;
	default ProjectileMovement.ProjectileGravityScale = 0;

	UPROPERTY()
	UNiagaraSystem ImpactEffect;

	UPROPERTY()
	USoundBase ImpactSound;

	UPROPERTY()
	USoundBase LoopingSound;

	UPROPERTY()
	UAudioComponent LoopingSoundComponent;

	UFUNCTION(BlueprintOverride)
	void EndPlay(EEndPlayReason EndPlayReason)
	{
		LoopingSoundComponent.Stop();
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		LoopingSoundComponent = Gameplay::SpawnSoundAttached(LoopingSound, GetRootComponent());
		check(LoopingSoundComponent != nullptr);
		SetLifeSpan(AuraConst::ProjectileLifeSpan);
	}

	// -----------------------------------------------------------------

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		Print("Overlapping with: " + OtherActor.Name);

		Gameplay::PlaySoundAtLocation(ImpactSound, GetActorLocation(), GetActorRotation());
		Niagara::SpawnSystemAtLocation(ImpactEffect, GetActorLocation(), GetActorRotation());
		DestroyActor();
	}

}
