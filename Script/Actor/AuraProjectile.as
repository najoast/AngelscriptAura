
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
	UNiagaraComponent Niagara;

	UPROPERTY(DefaultComponent)
	UProjectileMovementComponent ProjectileMovement;
	default ProjectileMovement.InitialSpeed = 550;
	default ProjectileMovement.MaxSpeed = 550;
	default ProjectileMovement.ProjectileGravityScale = 0;

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		Print("Overlapping with: " + OtherActor.Name);
		// DestroyActor();
		System::SetTimer(this, n"DestroyProjectile", 10.f, false);
	}

	UFUNCTION()
	private void DestroyProjectile()
	{
		DestroyActor();
	}
}
