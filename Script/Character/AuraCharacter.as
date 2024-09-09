
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


	// UFUNCTION(BlueprintOverride)
	// void Possessed(AController NewController)
	// {
	// }

	// --------- functions ----------

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		PlayerModuleMgr = Cast<UPlayerModuleMgr>(NewObject(this, UPlayerModuleMgr::StaticClass(), n"UPlayerModuleMgr"));
		PlayerModuleMgr.Ctor(this);
		PlayerModuleMgr.Init();

		// 因为是在 PlayerGasModule 里注册 AuraAttributeSet 的，所以 PlayerModuleMgr 必须在 Super::BeginPlay 之前调用，否则会导致这里面在 Apply 初始 GE 时失效
		// Because AuraAttributeSet is registered in PlayerGasModule, PlayerModuleMgr must be called before Super::BeginPlay, otherwise it will fail when Apply initial GE.
		Super::BeginPlay();
	}
}
