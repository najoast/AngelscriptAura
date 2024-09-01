
/*
Features:
1. Have a box component that is the size of the actor
2. Have a Niagara component that is the size of the actor
3. Have a infinite gameplay effect that is applied to the actor when it overlaps with another actor
4. When another actor ends overlapping with the actor, the gameplay effect is removed
*/

class AAuraNiagaraActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	USceneComponent SceneRoot;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	UBoxComponent Box;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	UNiagaraComponent Niagara;

	UPROPERTY()
	TSubclassOf<UGameplayEffect> GameplayEffectClass;

	FActiveGameplayEffectHandle EffectHandle;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		check(GameplayEffectClass != nullptr);
	}

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		Print("Overlapping with: " + OtherActor.Name);
		EffectHandle = AuraUtil::ApplyGameplayEffect(this, OtherActor, GameplayEffectClass);
	}

	UFUNCTION(BlueprintOverride)
	void ActorEndOverlap(AActor OtherActor)
	{
		Print("No longer overlapping with: " + OtherActor.Name);
		AuraUtil::RemoveGameplayEffect(OtherActor, EffectHandle);
		EffectHandle = AuraConst::EmptyEffectHandle;
	}
}
