SetByCallers allow the GameplayEffectSpec to carry float values associated with a GameplayTag or FName around. They are stored in their respective TMaps: TMap<FGameplayTag, float> and TMap<FName, float> on the GameplayEffectSpec. These can be used as Modifiers on the GameplayEffect or as generic means of ferrying floats around. It is common to pass numerical data generated inside of an ability to GameplayEffectExecutionCalculations or ModifierMagnitudeCalculations via SetByCallers.

> https://github.com/tranek/GASDocumentation?tab=readme-ov-file#4591-setbycallers

SetByCaller 是 GE 中指定数值的一种方式，它可以将数值存储在 GameplayEffectSpec 里，并且可以通过 SetByCallers 在 GE 里传递给其他地方。

数值存储在两个 TMap 里，一个以 GameplayTag 为 Key，一个以 FName 为 Key。

使用步骤：
1. 创建要使用的 Tag
2. 在创建 GE 的 GA 里，往 SetByCaller 里添加数值
3. 修改 GE 设置，使其 Modifier 为 SetByCaller，并选中要使用的 Tag

在 AS 里，有很多办法设置 SetByCaller 的值，我目前发现了两种，代码如下：
```cpp
AAuraProjectile ProjectileActor = Cast<AAuraProjectile>(SpawnActor(ProjectileClass, SourceLocation, Rotation, n"FireBolt", true));
if (ProjectileActor != nullptr) {
	FGameplayEffectSpecHandle SpecHandle = GasUtil::MakeGameplayEffectSpecHandle(AvatarActor, DamageEffectClass, GetAbilityLevel());
	SpecHandle.GetSpec().SetByCallerTagMagnitudes.Add(GameplayTags::Damage, 30); // 方法一
	SpecHandle.GetSpec().SetByCallerMagnitude(GameplayTags::Damage, 30); // 方法二
	ProjectileActor.DamageEffectSpecHandle = SpecHandle;
	FinishSpawningActor(ProjectileActor);
}
```
