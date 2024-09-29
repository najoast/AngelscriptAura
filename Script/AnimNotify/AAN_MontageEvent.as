
class UAAN_MontageEvent : UAnimNotify {
	UPROPERTY()
	FGameplayTag EventTag;

	UFUNCTION(BlueprintOverride)
	bool Notify(USkeletalMeshComponent MeshComp, UAnimSequenceBase Animation, FAnimNotifyEventReference EventReference) const {
		AbilitySystem::SendGameplayEventToActor(MeshComp.GetOwner(), EventTag, FGameplayEventData());
		return true;
	}
}
