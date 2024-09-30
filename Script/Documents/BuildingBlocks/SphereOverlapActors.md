
For non-projectile attacks, it is necessary to detect the collision between the weapon and the Victim. The general idea is to add a collision body (such as a Sphere) to the end of the weapon, and then detect the collision between this collision body and the Victim.

If the most accurate collision detection is required, this is necessary. But the disadvantage of doing so is that it is more troublesome and requires adding a collision body to the end of each weapon.

For projects that do not require precise collision, there is a simpler method: use a virtual collision ball for dynamic detection.

非子弹类攻击，需要检测武器和 Victim 的碰撞，一般思路是在武器的末端添加一个碰撞体（比如 Sphere），然后检测此碰撞体和 Victim 的碰撞。

如果需要最准确的碰撞检测，这样做是必须的。但这么做的缺点是比较麻烦，需要给每个武器末端都加一个碰撞体。

对于不需要精确碰撞的项目，有一种更简单的方法：使用一个虚拟的碰撞球进行动态检测。

***

In C++, it can be used like this:

```cpp
void UAuraAbilitySystemLibrary::GetLivePlayersWithinRadius(const UObject* WorldContextObject, TArray<AActor*>& OutOverlappingActors, const TArray<AActor*>& ActorsToIgnore, float Radius, const FVector& SphereOrigin)
{
	FCollisionQueryParams SphereParams;
	SphereParams.AddIgnoredActors(ActorsToIgnore);
	
	if (const UWorld* World = GEngine->GetWorldFromContextObject(WorldContextObject, EGetWorldErrorMode::LogAndReturnNull))
	{
		TArray<FOverlapResult> Overlaps;
		World->OverlapMultiByObjectType(Overlaps, SphereOrigin, FQuat::Identity, FCollisionObjectQueryParams(FCollisionObjectQueryParams::InitType::AllDynamicObjects), FCollisionShape::MakeSphere(Radius), SphereParams);
		for (FOverlapResult& Overlap : Overlaps)
		{
			if (Overlap.GetActor()->Implements<UCombatInterface>() && !ICombatInterface::Execute_IsDead(Overlap.GetActor()))
			{
				OutOverlappingActors.AddUnique(ICombatInterface::Execute_GetAvatar(Overlap.GetActor()));
			}
		}
	}
}
```

***

In Angelscript, it can be used like this:

```cpp
void GetLivePlayersWithinRadius(FGameplayEventData Payload, AAuraCharacterBase OwnerCharacter, FVector SourceLocation, FRotator Rotation) override {
	FVector AttackTargetLocation = OwnerCharacter.Weapon.GetSocketLocation(AuraConst::DefaultWeaponTipSocketName);
	float32 MeleeAttackRange = 30;

	TArray<EObjectTypeQuery> MeleeAttackTypes;
	MeleeAttackTypes.Add(EObjectTypeQuery::Pawn);
	
	TArray<AActor> ActorsToIgnore;
	ActorsToIgnore.Add(OwnerCharacter);

	TArray<AActor> OutActors;
	System::SphereOverlapActors(AttackTargetLocation, MeleeAttackRange, MeleeAttackTypes, AAuraCharacterBase::StaticClass(), ActorsToIgnore, OutActors);
}
```

[API Reference](https://angelscript.hazelight.se/api/#CClass:System:SphereOverlapActors)
