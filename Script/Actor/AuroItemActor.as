
class AAuroItemActor : AActor
{
	UPROPERTY(DefaultComponent, RootComponent)
	USceneComponent SceneRoot;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	UStaticMeshComponent Mesh;

	UPROPERTY(DefaultComponent, Attach = SceneRoot)
	USphereComponent Sphere;

	// The ID of the item. Configured in the DataTable DT_SData_Item
	UPROPERTY()
	EItemID ItemID;

	// The level of the actor, used to determine the level of the gameplay effect
	UPROPERTY()
	float32 ActorLevel = 1;

	UFUNCTION(BlueprintOverride)
	void ActorBeginOverlap(AActor OtherActor)
	{
		FSDataItem Item = SData::GetItem(ItemID);
		AuraUtil::ApplyGameplayEffect(this, OtherActor, Item.GameplayEffectClass, ActorLevel);

		UAuraGameInstanceSubsystem::Get().EventMgr.OnItemPickedUpEvent.Broadcast(ItemID);

		DestroyActor();
	}
}