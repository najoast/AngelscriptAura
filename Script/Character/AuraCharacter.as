
class AAuraCharacter : AAuraCharacterBase
{
	UPROPERTY(DefaultComponent)
	USpringArmComponent SpringArm;
	default SpringArm.SetRelativeRotation(FRotator(-45, 0, 0));
	default SpringArm.TargetArmLength = 850;

	UPROPERTY(DefaultComponent, Attach = "SpringArm")
	UCameraComponent Camera;

	// --------------------------------------
	UPlayerModuleMgr PlayerModuleMgr;

	// --------- ctor --------
	default CharacterMovement.bOrientRotationToMovement = true;
	default CharacterMovement.RotationRate = FRotator(0, 400, 0);
	default CharacterMovement.bConstrainToPlane = true;
	default CharacterMovement.bSnapToPlaneAtStart = true;
	default bUseControllerRotationPitch = false;
	default bUseControllerRotationRoll = false;
	default bUseControllerRotationYaw = false;
	default Tags.Add(AuraConst::PlayerTag);

	void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData) override
	{
		AuraUtil::GameInstance().EventMgr.OnAttributeChangedEvent.Broadcast(AttributeChangeData);
	}

	// void InitPlayerModuleMgr()
	// {
	// 	PlayerModuleMgr = Cast<UPlayerModuleMgr>(NewObject(this, UPlayerModuleMgr::StaticClass(), n"UPlayerModuleMgr"));
	// 	PlayerModuleMgr.Ctor(this);
	// 	PlayerModuleMgr.Init();
	// }

	// UFUNCTION(BlueprintOverride)
	// void Possessed(AController NewController)
	// {
	// 	// Init player module manager for the server
	// 	InitPlayerModuleMgr();
	// }

	// --------- functions ----------

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		// const bool IsDedicatedServer = System::IsDedicatedServer();
		PlayerModuleMgr = Cast<UPlayerModuleMgr>(NewObject(this, UPlayerModuleMgr::StaticClass(), n"UPlayerModuleMgr"));
		PlayerModuleMgr.Ctor(this);
		PlayerModuleMgr.Init();

		Super::BeginPlay();
	}
}
