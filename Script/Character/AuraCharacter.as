
class AAuraCharacter : AAuraCharacterBase
{
	UPROPERTY(DefaultComponent)
	USceneComponent Root;

	UPROPERTY(DefaultComponent, Attach = "Root")
	USpringArmComponent SpringArm;
	default SpringArm.SetRelativeRotation(FRotator(-45, 0, 0));
	default SpringArm.TargetArmLength = 750;

	UPROPERTY(DefaultComponent, Attach = "SpringArm")
	UCameraComponent Camera;

	UPlayerModuleMgr PlayerModuleMgr;

	// --------- ctor --------
	default CharacterMovement.bOrientRotationToMovement = true;
	default CharacterMovement.RotationRate = FRotator(0, 400, 0);
	default CharacterMovement.bConstrainToPlane = true;
	default CharacterMovement.bSnapToPlaneAtStart = true;
	default bUseControllerRotationPitch = false;
	default bUseControllerRotationRoll = false;
	default bUseControllerRotationYaw = false;

	// --------- functions ----------

	// UFUNCTION(BlueprintOverride)
	// void Possessed(AController NewController)
	// {
	// }

	UPROPERTY(Category = "Attributes")
	TArray<TSubclassOf<UGameplayEffect>> InitAppliedEffects;

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		PlayerModuleMgr = Cast<UPlayerModuleMgr>(NewObject(this, UPlayerModuleMgr::StaticClass(), n"UPlayerModuleMgr"));
		PlayerModuleMgr.Ctor(this);

		InitAbilityActorInfo();
	}

	// https://github.com/DruidMech/GameplayAbilitySystem_Aura/blob/main/Source/Aura/Private/Character/AuraCharacter.cpp
	void InitAbilityActorInfo()
	{
		for (auto EffectClass : InitAppliedEffects)
		{
			AuraUtil::ApplyGameplayEffect(this, this, EffectClass);
		}

		PlayerModuleMgr.Init();
	}
}