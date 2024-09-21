
在[第138课](https://github.com/DruidMech/GameplayAbilitySystem_Aura/commit/b456a9af9a4eea31c35228621c8d5c3ebae67596), 老师提供了一种有趣的死法。

本来是有个死亡动画的，但是老师没用，而是使用的 Ragdoll 的死亡方式。这种死亡方式的特点：
- 武器和角色分离
- 武器和角色各自开启物理效果和重力效果

做了以上操作后，角色和武器在重力的作用下很自然的倒下，给人一种非常像现实世界的感觉。

而且由于模拟了物理，所以角色会在死亡的瞬间有千变万化的反应，就像是在现实世界中死亡一样。

现实中死亡后人突然断片，会在重力作用下自然倒下，Ragdoll 的死亡方式非常自然，是很好的选择。

***

代码示例：

```cpp
	void RagdollDie()
	{
		Weapon.DetachFromComponent(EDetachmentRule::KeepWorld, EDetachmentRule::KeepWorld, EDetachmentRule::KeepWorld, true);
		RagdollComponent(Weapon);
		RagdollComponent(Mesh);
		CapsuleComponent.SetCollisionEnabled(ECollisionEnabled::NoCollision);
	}

	void RagdollComponent(UPrimitiveComponent Component)
	{
		Component.SetSimulatePhysics(true);
		Component.SetEnableGravity(true);
		Component.SetCollisionEnabled(ECollisionEnabled::PhysicsOnly);
		Component.SetCollisionResponseToChannel(ECollisionChannel::ECC_WorldStatic, ECollisionResponse::ECR_Block);
	}
```

步骤:
1. 武器和角色分离
2. 分别设置武器和Mesh组件的物理状态：
	- 开启物理模拟
	- 开启重力
	- 设置碰撞响应为“仅物理”（原因是只需要模拟物理碰撞，别的不需要）
	- 设置碰撞响应频道为：Block WorldStatic（原因是要和场景里的静态对象发生碰撞）
3. 设置 CapsuleComponent 的碰撞响应为“不碰撞”（原因是默认角色的碰撞检查是使用这个组件的，如果在Ragdoll期间不关闭，会使用死亡碰撞不自然，从而穿帮）
