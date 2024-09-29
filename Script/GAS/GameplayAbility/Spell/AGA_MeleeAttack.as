
class UAGA_MeleeAttack : UAGA_SpellBase {
	bool CastSpell(FGameplayEventData Payload, AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
		// if (Payload.Target == nullptr) {
		// 	Print("Target is null");
		// 	return false;
		// }
		
		// TODO: 使用 Payload 传递攻击目录，否则会导致玩家放近战技能时，放完技能移开鼠标后，动画播完找不到攻击目标
		AAuraCharacterBase TargetCharacter = Cast<AAuraCharacterBase>(OwnerCharacter.GetAttackTarget());
		if (TargetCharacter == nullptr) {
			Print("Target is null");
			return false;
		}

		// System::DrawDebugSphere(GetAvatarActorFromActorInfo().GetActorLocation(), 50, 12, FLinearColor::Black, 0.5);
		FGameplayEffectSpecHandle SpecHandle = GasUtil::MakeGameplayEffectSpecHandle(OwnerCharacter, DamageEffectClass, GetAbilityLevel());
		if (SpecHandle.IsValid()) {
			if (TargetCharacter != nullptr) {
				TargetCharacter.AbilitySystem.ApplyGameplayEffectSpecToSelf(SpecHandle);
			}
		}
		return true;
	}
}
