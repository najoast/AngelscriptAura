namespace AuraConst {
	const FActiveGameplayEffectHandle EmptyEffectHandle = FActiveGameplayEffectHandle();
	const FAngelscriptGameplayAttributeData EmptyAttributeData = FAngelscriptGameplayAttributeData();

	const FName DefaultWeaponTipSocketName = n"TipSocket";
	const FName PlayerTag = n"Player";
	const FName EnemyTag = n"Enemy";

	const FName AI_Blackboard_Key_IsHitReacting = n"IsHitReacting";
	const FName AI_Blackboard_Key_TargetToFollow = n"TargetToFollow";

	const int DefaultAbilityInputID = 2754;
	const float ProjectileLifeSpan = 15;
	const int ProjectileMaxSpeed = 550;
	const float32 GhostProgressChaseSpeed = 0.1; // 影子进度条更新速度

	// Combat
	const float32 HitChanceMin = 0.05;
	const float32 HitChanceMax = 0.95;
	const float32 CritDamageMin = 1.2;
	const float32 CritDamageMax = 2;
	const int32 DamageTypeOffset = 10000000;
	const float32 LuckyDamageRatio = 0.7; // 如果随机到伤害范围的前 X%，就算是幸运一击; 0.7 表示前 70%
	const float32 MeleeAttackRange = 30;
}
