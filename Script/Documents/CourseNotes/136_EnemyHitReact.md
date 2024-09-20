
怪物受击动画实现方案：
1. 给怪物一个初始的 GA 叫 GA_HitReact
2. GA_HitReact 触发时，播放 AM_HitReact 动画，并限制移动
3. 动画播完后，恢复移动

注：教程里添加了一个 Tas: `Effects.HitReact` 和一个 GE: `GE_HitReact`，没什么必要。

在完成这一节的功能时，有一些知识点生疏了，下面记录一下：
1. 创建 GA 的流程是先在 AS 里创建 AGA 类，然后根据是否有“需要在Editor里设置的项”来决定是否要创建对应的 GA 类，如果没有就不需要创建 GA 类了。
2. 使用 GiveAbility 给 ASC 添加 Ability。
3. 在 AGA 类里，重载 ActivateAbility 来实现该 Ability 的功能。
4. 一般会有个回调，比如播放 Montage 后的回调，表示这个 Ability 执行完毕。在这个执行完毕的回调里，调用 EndAbility 来结束该 Ability。(也就是说，激活是外面来负责，但是结束是自己负责)
