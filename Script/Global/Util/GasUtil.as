namespace GasUtil
{
	FActiveGameplayEffectHandle ApplyGameplayEffect(AActor SourceActor, AActor TargetActor, TSubclassOf<UGameplayEffect> GameplayEffectClass, float32 Level = 1)
	{
		UAbilitySystemComponent TargetASC = AbilitySystem::GetAbilitySystemComponent(TargetActor);
		if (TargetASC == nullptr) {
			return FActiveGameplayEffectHandle();
		}

		check(GameplayEffectClass != nullptr);
		FGameplayEffectContextHandle EffectContextHandle = TargetASC.MakeEffectContext();
		EffectContextHandle.AddSourceObject(SourceActor);
		FGameplayEffectSpecHandle EffectSpecHandle = TargetASC.MakeOutgoingSpec(GameplayEffectClass, Level, EffectContextHandle);
		return TargetASC.ApplyGameplayEffectSpecToSelf(EffectSpecHandle);
	}

	bool RemoveGameplayEffect(AActor TargetActor, FActiveGameplayEffectHandle EffectHandle, int StacksToRemove = -1)
	{
		UAbilitySystemComponent TargetASC = AbilitySystem::GetAbilitySystemComponent(TargetActor);
		if (TargetASC == nullptr) {
			return false;
		}
		return TargetASC.RemoveActiveGameplayEffect(EffectHandle, StacksToRemove);
	}

	FGameplayAbilitySpecHandle GiveAbility(AActor TargetActor, TSubclassOf<UGameplayAbility> AbilityClass, int Level = 1, int InputID = AuraConst::DefaultAbilityInputID, UObject SourceObject = nullptr)
	{
		UAbilitySystemComponent TargetASC = AbilitySystem::GetAbilitySystemComponent(TargetActor);
		if (TargetASC == nullptr) {
			return FGameplayAbilitySpecHandle();
		}

		FGameplayAbilitySpec AbilitySpec = FGameplayAbilitySpec(AbilityClass, Level, InputID, SourceObject);
		return TargetASC.GiveAbility(AbilitySpec);
	}

	FGameplayAbilitySpec MakeAbilitySpec(TSubclassOf<UGameplayAbility> AbilityClass, int Level = 1)
	{
		FGameplayAbilitySpec AbilitySpec = FGameplayAbilitySpec(AbilityClass, Level);
		return AbilitySpec;
	}
}