
class UAGA_RangedAttack : UAGA_EnemySpell
{
	void OnGameplayEventReceived(FGameplayEventData Payload) override
	{
		System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Purple, 0.5);
	}
}