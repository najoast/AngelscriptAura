
class AAuroEffectActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	UStaticMeshComponent Mesh;

	UPROPERTY(DefaultComponent, Attach = "Mesh")
	USphereComponent Sphere;

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		Print("Overlapping with: " + OtherActor.Name);
		auto AngelscriptGASCharacter = Cast<AAngelscriptGASCharacter>(OtherActor);
		if (AngelscriptGASCharacter != nullptr)
		{
			const UAttributeSet AttributeSet = AngelscriptGASCharacter.AbilitySystem.GetAttributeSet(UAuraAttributeSet::StaticClass());
			UAuraAttributeSet AuraAttributeSet = Cast<UAuraAttributeSet>(AttributeSet);
			AuraAttributeSet.Health.SetCurrentValue(AuraAttributeSet.Health.GetCurrentValue() + 10);
			DestroyActor();
		}
	}

	UFUNCTION(BlueprintOverride)
	void ActorEndOverlap(AActor OtherActor)
	{
		Print("No longer overlapping with: " + OtherActor.Name);
	}
}