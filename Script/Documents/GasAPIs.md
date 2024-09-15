# 常用 GAS APIs

- 以下列出的所有接口都是可以在 AS 里使用的。
- 注释前有 [AS] 的表示是 AS 的接口，没有 [AS] 的表示是 C++ 的接口。
- 很多 C++ 接口在 AS 里名字会变，如果变了会在下面标注。

```c++
// 根据 InputID 获取所有的 AbilitySpec
void UAbilitySystemComponent::FindAllAbilitySpecsFromInputID(int32 InputID, TArray<const FGameplayAbilitySpec*>& OutAbilitySpecs) const

// 根据 InputID 获取所有的 AbilitySpecHandle
void UAbilitySystemComponent::FindAllAbilitiesWithInputID(OUT TArray<FGameplayAbilitySpecHandle>& OutAbilityHandles, int32 InputID /*= 0*/) const

// [AS] 根据 AbilitySpecHandle 获取 AbilitySpec
const UGameplayAbility AbilitySystem::GetGameplayAbilityFromSpecHandle(UAbilitySystemComponent AbilitySystem, FGameplayAbilitySpecHandle AbilitySpecHandle, bool& bIsInstance)

// [AS] Returns an array with all granted ability handles
// NOTE: currently this doesn't include abilities that are mid-activation
// OutAbilityHandles - This array will be filled with the granted Ability Spec Handles
void UAbilitySystemComponent.GetAllAbilities(TArray<FGameplayAbilitySpecHandle>& OutAbilityHandles) const

// [AS] Returns an array with all granted ability handles that are active
bool UAbilitySystemComponent.FindAbilitySpecFromHandle(FGameplayAbilitySpecHandle Handle, FGameplayAbilitySpec& OutSpec)

```

// Get PlayerController from AbilityTask
```cpp
class UUAT_TargetDataUnderMouse : UAngelscriptAbilityTask {
	UFUNCTION(BlueprintOverride)
	void Activate() {
		UAngelscriptAbilitySystemComponent ASC = Cast<UAngelscriptAbilitySystemComponent>(GetAbilitySystemComponent());
		if (ASC != nullptr) {
			APlayerController PC = ASC.GetAbilityActorInfo().PlayerController;
		}
	}
}
```
