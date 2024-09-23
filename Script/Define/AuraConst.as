namespace AuraConst
{
	const FActiveGameplayEffectHandle EmptyEffectHandle = FActiveGameplayEffectHandle();
	const FAngelscriptGameplayAttributeData EmptyAttributeData = FAngelscriptGameplayAttributeData();

	const FName DefaultWeaponTipSocketName = n"TipSocket";
	const int DefaultAbilityInputID = 2754;
	const float ProjectileLifeSpan = 15;
	const int ProjectileMaxSpeed = 550;
	const float32 GhostProgressChaseSpeed = 0.1; // 影子进度条更新速度

	// Combat
	const float32 HitChanceMin = 0.05;
	const float32 HitChanceMax = 0.95;
	const float32 CritDamageMin = 1.2;
	const float32 CritDamageMax = 2;
}
