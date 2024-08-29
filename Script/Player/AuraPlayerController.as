
class AAuraPlayerController : APlayerController
{
	// Properties
	UPROPERTY(Category = "Input")
	UInputMappingContext AuraContext;

	UPROPERTY(Category = "Input")
	UInputAction MoveAction;

	// Ctor
	default DefaultMouseCursor = EMouseCursor::Default;

	// Members
	AAuraEnemy LastEnemy;
	AAuraEnemy ThisEnemy;

	// Functions
	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		check(AuraContext != nullptr);
		UEnhancedInputLocalPlayerSubsystem Subsystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
		if (Subsystem != nullptr) {
			FModifyContextOptions Option;
			Subsystem.AddMappingContext(AuraContext, 0, Option);
		}

		bShowMouseCursor = true;

		Widget::SetInputMode_GameAndUIEx(this, bHideCursorDuringCapture = false);

		SetupInputComponent();
	}

	UFUNCTION(BlueprintOverride)
	void Tick(float DeltaTime)
	{
		CursorTrace();
	}

	void CursorTrace()
	{
		FHitResult HitResult;
		GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, HitResult);
		if (!HitResult.bBlockingHit) {
			return;
		}

		// AActor Actor = HitResult.GetActor();
		// if (Actor != nullptr) {
		// 	Print("Actor: " + Actor.Name);
		// }

		LastEnemy = ThisEnemy;
		ThisEnemy = Cast<AAuraEnemy>(HitResult.GetActor());

		/*
			Case	Last	This
			#1		0		0
			#2		1		0
			#3		0		1
			#4		1		1
		*/
		if (LastEnemy == nullptr && ThisEnemy == nullptr) {
			return;
		}
		if (LastEnemy != nullptr && ThisEnemy == nullptr) {
			LastEnemy.Unhighlight();
		}
		if (LastEnemy == nullptr && ThisEnemy != nullptr) {
			ThisEnemy.Highlight();
		}
		if (LastEnemy != nullptr && ThisEnemy != nullptr) {
			if (LastEnemy != ThisEnemy) {
				LastEnemy.Unhighlight();
				ThisEnemy.Highlight();
			}
		}
	}

    void SetupInputComponent()
	{
		auto MyInputComponent = GetComponentByClass(TSubclassOf<UInputComponent>(UInputComponent::StaticClass()));
        UEnhancedInputComponent EnhancedInput = Cast<UEnhancedInputComponent>(MyInputComponent);
		EnhancedInput.BindAction(MoveAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"Move"));
	}

	UFUNCTION()
	void Move(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction)
	{
		FRotator ControllerRotation = GetControlRotation();
		ControllerRotation.Pitch = 0.f;
		ControllerRotation.Roll = 0.f;
		FVector ControllerForwardVector = ControllerRotation.GetForwardVector();
		FVector ControllerRightVector = ControllerRotation.GetRightVector();

		APawn MyControlledPawn = GetControlledPawn();
		MyControlledPawn.AddMovementInput(ControllerForwardVector, ActionValue.Axis2D.Y);
		MyControlledPawn.AddMovementInput(ControllerRightVector, ActionValue.Axis2D.X);
	}
}