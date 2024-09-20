
这一课的标题是 Ability Damage，讲的是怎么用一个 CurveTable 来给一个 GA 设置伤害。

本身没什么意思啊，因为伤害计算不是这么弄的，后面我会有正式点的设计。但这节课里有一个有意思的点，那就是在 UAuraGameplayAbility 里，我们可以用 FScalableFloat 来表示一个伤害值，而不是普通的 float。
这样做有个好处，可以在编辑器里选择一个 CurveTable，然后根据不同等级取出不同的伤害值。

用法：
```cpp
class UAuraGameplayAbility : UGameplayAbility
{

	UPROPERTY(Category = "Damage")
	FScalableFloat Damage;

	void SomeFunction()
	{
		const float ScaledDamage = Damage.GetValueAtLevel(GetAbilityLevel());
	}
}
```
