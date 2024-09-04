
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	UPROPERTY(DefaultComponent, Category = "Combat", Attach = "CharacterMesh0", AttachSocket = "WeaponHandSocket")
	USkeletalMeshComponent Weapon;
	default Weapon.SetCollisionEnabled(ECollisionEnabled::NoCollision);

	UPROPERTY(Category = "Attributes")
	TArray<TSubclassOf<UGameplayEffect>> InitAppliedEffects;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		InitAbilityActorInfo();
	}

	// https://github.com/DruidMech/GameplayAbilitySystem_Aura/blob/main/Source/Aura/Private/Character/AuraCharacter.cpp
	void InitAbilityActorInfo()
	{
		// This is how we register an attribute set with an actor.
		UAuraAttributeSet AttributeSet = Cast<UAuraAttributeSet>(AbilitySystem.RegisterAttributeSet(UAuraAttributeSet::StaticClass()));
		AbilitySystem.InitAbilityActorInfo(this, this);	

		auto PlayerController = GetLocalViewingPlayerController();
		if (PlayerController != nullptr)
		{
			auto AuraHUD = Cast<AAuraHUD>(PlayerController.GetHUD());
			if (AuraHUD != nullptr)
			{
				AuraHUD.InitOverlay(PlayerController, PlayerState, AbilitySystem, AttributeSet);
			}
		}
		
		for (auto EffectClass : InitAppliedEffects)
		{
			AuraUtil::ApplyGameplayEffect(this, this, EffectClass);
		}
	}
}
