
# 没有 InputID 的情况下如何在 AS 里遍历所有的 AbilitySpec

```c++
TArray<FGameplayAbilitySpecHandle> OutAbilityHandles;
ASC.GetAllAbilities(OutAbilityHandles);
for (FGameplayAbilitySpecHandle AbilitySpecHandle : OutAbilityHandles) {
	FGameplayAbilitySpec OuterAbilitySpec;
	if (ASC.FindAbilitySpecFromHandle(AbilitySpecHandle, OuterAbilitySpec)) {
		if (!OuterAbilitySpec.IsActive()) {
			ASC.TryActivateAbility(OuterAbilitySpec.Handle);
		}
	}
}
```

这个方法的缺点是，有两次 for 循环，一次是 ASC.GetAllAbilities 得到的 AbilitySpecHandle 集合，一次是 FindAbilitySpecFromHandle 里的遍历。
这两个 for 循环都是对 ActivatableAbilities 的遍历，更显得愚蠢了。

推荐给所有 Ability 加上 InputID，倒不是说业务上有什么必要，只不过刚好 UE 提供了根据 InputID 直接拿 TArray<FGameplayAbilitySpec> 的接口，
上面之所以要遍历两次，就是因为 GetAllAbilities 返回的是 TArray<FGameplayAbilitySpecHandle>，而 FGameplayAbilitySpecHandle 在 AS 里没有导出任何属性和方法，
必须再通过 FindAbilitySpecFromHandle 拿到 FGameplayAbilitySpec 后才能调用 IsActive 方法。

# 有 InputID 的情况下如何在 AS 里遍历所有的 AbilitySpec

有两个接口，一个拿到 Spec 的，一个拿到 Handle 的：
```c++
void UAbilitySystemComponent::FindAllAbilitySpecsFromInputID(int32 InputID, TArray<const FGameplayAbilitySpec*>& OutAbilitySpecs) const
void UAbilitySystemComponent::FindAllAbilitiesWithInputID(OUT TArray<FGameplayAbilitySpecHandle>& OutAbilityHandles, int32 InputID /*= 0*/) const
```

上述代码可简化为：
```c++
TArray<FGameplayAbilitySpec> OutAbilitySpecs;
ASC.FindAllAbilitySpecsFromInputID(InputID, OutAbilitySpecs);
for (FGameplayAbilitySpec AbilitySpec : OutAbilitySpecs) {
	if (!AbilitySpec.IsActive()) {
		ASC.TryActivateAbility(AbilitySpec.Handle);
	}
}
```

简化后只需要一次 for 循环。