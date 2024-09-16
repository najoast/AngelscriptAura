
enum EPlayerModule
{
	None = 0,
	Gas  = 1,
}

enum EItemID
{
	None          = 0,
	HealthPotion  = 1,
	ManaPotion    = 2,
	HealthCrystal = 3,
	ManaCrystal   = 4,
}

// Enum Alias
namespace AuraEnum
{
	const ECollisionChannel ECC_Projectile = ECollisionChannel::ECC_GameTraceChannel1;
}
