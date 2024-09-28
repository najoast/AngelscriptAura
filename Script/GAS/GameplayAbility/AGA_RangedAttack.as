
class UAGA_RangedAttack : UAuraGameplayAbility
{

	UFUNCTION(BlueprintOverride)
	void ActivateAbility()
	{
		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Purple, 0.5);
	}
}