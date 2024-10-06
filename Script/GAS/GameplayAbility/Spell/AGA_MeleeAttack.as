/*
Melee attack steps:
1. AI determines the attack target
2. Move close to the target
3. Play the attack animation montage & Turn towards the attack direction (MotionWarping SetFacingTarget)
4. Weapon collision detection, cast GE on the target
*/

class UAGA_MeleeAttack : UAGA_SpellBase {

	const TArray<EObjectTypeQuery> MeleeAttackTypes;
	default MeleeAttackTypes.Add(EObjectTypeQuery::Pawn);

	bool CastSpell(FGameplayEventData Payload, AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
		FVector AttackTargetLocation = OwnerCharacter.GetSocketLocationByGameplayTag(GetCurrentEventTag());
		// System::DrawDebugSphere(AttackTargetLocation, AuraConst::MeleeAttackRange, 12, FLinearColor::Black, 0.5);
		
		TArray<AActor> ActorsToIgnore;
		ActorsToIgnore.Add(OwnerCharacter);

		TArray<AActor> OutActors;
		if (!System::SphereOverlapActors(AttackTargetLocation, AuraConst::MeleeAttackRange, MeleeAttackTypes, AAuraCharacterBase::StaticClass(), ActorsToIgnore, OutActors)) {
			return false;
		}

		for (AActor Actor : OutActors) {
			AAuraCharacterBase TargetCharacter = Cast<AAuraCharacterBase>(Actor);
			if (TargetCharacter != nullptr) {
				FGameplayEffectSpecHandle SpecHandle = GasUtil::MakeGameplayEffectSpecHandle(OwnerCharacter, DamageEffectClass, GetAbilityLevel());
				if (SpecHandle.IsValid()) {
					if (TargetCharacter != nullptr) {
						TargetCharacter.AbilitySystem.ApplyGameplayEffectSpecToSelf(SpecHandle);
					}
				}
			}
		}

		return true;
	}
}
