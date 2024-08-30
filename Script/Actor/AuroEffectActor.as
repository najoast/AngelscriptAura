
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

		UAbilitySystemComponent OtherASC = AbilitySystem::GetAbilitySystemComponent(OtherActor);
		if (OtherASC != nullptr)
		{
			check(GameplayEffectClass != nullptr);
			FGameplayEffectContextHandle EffectContextHandle = OtherASC.MakeEffectContext();
			EffectContextHandle.AddSourceObject(this);
			FGameplayEffectSpecHandle EffectSpecHandle = OtherASC.MakeOutgoingSpec(GameplayEffectClass, 1, EffectContextHandle);
			OtherASC.ApplyGameplayEffectSpecToSelf(EffectSpecHandle);
			DestroyActor();
		}
	}

	UFUNCTION(BlueprintOverride)
	void ActorEndOverlap(AActor OtherActor)
	{
		// Print("No longer overlapping with: " + OtherActor.Name);
	}
}