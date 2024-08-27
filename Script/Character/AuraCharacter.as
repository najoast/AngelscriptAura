
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

	// --------- ctor --------
	default CharacterMovement.bOrientRotationToMovement = true;
	default CharacterMovement.RotationRate = FRotator(0, 400, 0);
	default CharacterMovement.bConstrainToPlane = true;
	default CharacterMovement.bSnapToPlaneAtStart = true;
	default bUseControllerRotationPitch = false;
	default bUseControllerRotationRoll = false;
	default bUseControllerRotationYaw = false;
}