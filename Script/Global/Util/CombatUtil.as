
namespace CombatUtil
{
	float32 EncodeDamage(float32 Damage, EDamageType DamageType)
	{
		return int32(DamageType) * AuraConst::DamageTypeOffset + Damage;
	}

	void DecodeDamage(float32 Damage, float32& OutDamage, EDamageType& OutDamageType)
	{
		OutDamageType = EDamageType(Damage / AuraConst::DamageTypeOffset);
		OutDamage = Damage % AuraConst::DamageTypeOffset;
	}
}