
class UAGA_MeleeAttack : UAuraGameplayAbility
{
	
	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Black, 0.5);
	}
}