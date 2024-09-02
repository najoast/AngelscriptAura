/*
Features:
1. Have a static mesh component that is the mesh of the actor
2. Have a sphere component that is the collision size of the actor
3. Have a non-infinite gameplay effect that is applied to the actor when it overlaps with another actor
4. Destroy self when the gameplay effect is applied (overlapping with another actor)
*/

class AAuroEffectActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	USceneComponent SceneRoot;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	UStaticMeshComponent Mesh;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	USphereComponent Sphere;

	UPROPERTY()
	TSubclassOf<UGameplayEffect> GameplayEffectClass;

	// The level of the actor, used to determine the level of the gameplay effect
	UPROPERTY()
	float32 ActorLevel = 1;

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		Print("Overlapping with: " + OtherActor.Name);
		// auto AngelscriptGASCharacter = Cast<AAngelscriptGASCharacter>(OtherActor);
		// if (AngelscriptGASCharacter != nullptr)
		// {
		// 	const UAttributeSet AttributeSet = AngelscriptGASCharacter.AbilitySystem.GetAttributeSet(UAuraAttributeSet::StaticClass());
		// 	UAuraAttributeSet AuraAttributeSet = Cast<UAuraAttributeSet>(AttributeSet);
		// 	AuraAttributeSet.Health.SetCurrentValue(AuraAttributeSet.Health.GetCurrentValue() + 10);
		// 	DestroyActor();
		// }

		AuraUtil::ApplyGameplayEffect(this, OtherActor, GameplayEffectClass, ActorLevel);
		DestroyActor();
	}

	UFUNCTION(BlueprintOverride)
	void ActorEndOverlap(AActor OtherActor)
	{
		// Print("No longer overlapping with: " + OtherActor.Name);
	}
}