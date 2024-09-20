
# Meta Attribute
元属性指的是一些辅助性质的，不是玩家直接能看到的属性，也不会 Replicate 给客户端。

比如这节课里的示例： IncomingDamage

之前有一个 GE 叫 GE_Damage，它的效果是直接对 Health 属性做一个 Add 操作，Magnitude 是硬编码的 -10。
这样相当于这个 GE 直接修改目标的 Health 属性，没有中间过程，两边耦合在一起了。
而 Meta Attribute 就是用来解耦的，修改后的流程：
- GE_Damge 不再直接修改 Health 属性，改为修改 IncomingDamage 属性
- 在 UAuraAttributeSet::PostGameplayEffectExecute 里，监控 IncomingDamage 属性的变动，然后进行一系列计算后，再把结果应用到 Health 属性上

这样做的好处：
- 攻击方施加的 GE 和受击方的 Health 解耦，提供一个中间节点对伤害进行计算

# Building Blocks

1. 新建一个 Meta Attribute，命名为 IncomingDamage
2. 修改 GE_Damage，把其影响的属性改为 IncomingDamage
3. 在 UAuraAttributeSet::PostGameplayEffectExecute 里，检查 IncomingDamage 属性的变动，并做一系列计算后，再把结果应用到 Health 属性上

```cpp
void ProcessMetaAttribute(FGameplayEffectSpec EffectSpec, FGameplayModifierEvaluatedData& EvaluatedData, UAngelscriptAbilitySystemComponent TargetASC)
{
	if (EvaluatedData.Attribute.AttributeName == AuraAttributes::IncomingDamage) {
		// 缓存 IncomingDamage 属性的值
		float32 IncomingDamageMagnitude = EvaluatedData.GetMagnitude();
		TargetASC.SetAttributeBaseValue(this.Class, AuraAttributes::IncomingDamage, 0);
		if (IncomingDamageMagnitude > 0) {
			// 在这里做更多的伤害计算，比如计算间避、暴击等等
			const float NewHealth = Math::Clamp(Health.GetBaseValue() - IncomingDamageMagnitude, 0, MaxHealth.GetCurrentValue());
			TargetASC.SetAttributeBaseValue(this.Class, AuraAttributes::Health, NewHealth);
			if (NewHealth == 0) {
				Print(f"Target is dead");
			}
		}
	}
}
```
