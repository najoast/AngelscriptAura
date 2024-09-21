
Dissolve 效果，可以实现溶解效果，具体内容可看这节课：https://www.udemy.com/course/unreal-engine-5-gas-top-down-rpg/learn/lecture/39867794#overview

主要用到了 Material Instance，这个具体怎么做的我也不清楚，在 MI 的蓝图里实现的，这个好像没法用 AS 来实现，属于美术资产的范畴，程序员如果没兴趣可以不学。

但是老师提到了，这个效果是可以抄的，在 Aura 工程里的有一个模板 Dissolve MI，可以把里面的蓝图代码复制到别的 MI 里，然后改一下参数就可以实现同样效果了。

这里违背了 DRY 原则，后面如果要用，看能不能想办法复用 Dissolve 的蓝图代码，或者用 AS 实现。

在 AS 代码里使用 Dissolve MI 的示例代码可参考 Ticker.md。

```cpp
// 创建 UMaterialInstanceDynamic 实例，并设置到组件上，使用的是 UPrimitiveComponent.SetMaterial
UMaterialInstanceDynamic MID_WeaponDissolve = Material::CreateDynamicMaterialInstance(SDataCharacter.WeaponDissolveMaterial);
Weapon.SetMaterial(0, MID_WeaponDissolve);

// 后续在 Timer/Ticker/Tick/TimelineComponent 等，不管你用什么手段，更新 Dissole 的进度
// 注意第一个参数，是在 MI 资产里设置的变量名，自己去资产里看下叫什么，不一定是这个名字，对上就行
Weapon.SetScalarParameterValueOnMaterials(n"Dissolve", Percent);
```
