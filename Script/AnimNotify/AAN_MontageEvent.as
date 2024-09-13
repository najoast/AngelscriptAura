
class UAAN_MontageEvent : UAnimNotify
{
	UFUNCTION(BlueprintOverride)
	bool Notify(USkeletalMeshComponent MeshComp, UAnimSequenceBase Animation,
	            FAnimNotifyEventReference EventReference) const
	{
		AbilitySystem::SendGameplayEventToActor(MeshComp.GetOwner(), GameplayTags::Event_Montage_FireBolt, FGameplayEventData());
		return true;
	}
}
