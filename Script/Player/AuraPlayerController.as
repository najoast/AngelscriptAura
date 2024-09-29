
class AAuraPlayerController : APlayerController {
	default bReplicates = true;

	// Properties
	UPROPERTY(Category = "Input")
	UInputMappingContext AuraContext;

	UPROPERTY(Category = "Input")
	UInputAction MoveAction;

	UPROPERTY(Category = "Input")
	UInputAction ShiftAction;

	UPROPERTY(DefaultComponent)
	USplineComponent MovementSpline;

	// Members
	AAuraCharacter OwnerCharacter;
	AAuraEnemy LastEnemy;
	AAuraEnemy ThisEnemy;
	UAbilitySystemComponent AbilitySystemComponent;
	FHitResult HitResult;
	private UClickToMove ClickToMove;
	private bool bShiftPressed = false;

	// Ctor
	default DefaultMouseCursor = EMouseCursor::Default;

	// Functions
	UFUNCTION(BlueprintOverride)
	void BeginPlay() {
		// Print("========================== AuraPlayerController BeginPlay ==========================");
		// bool IsDedicatedServer = System::IsDedicatedServer();
		check(AuraContext != nullptr);
		UEnhancedInputLocalPlayerSubsystem Subsystem = UEnhancedInputLocalPlayerSubsystem::Get(this);
		if (Subsystem != nullptr) {
			Subsystem.AddMappingContext(AuraContext, 0, FModifyContextOptions());
		}

		bShowMouseCursor = true;

		Widget::SetInputMode_GameAndUIEx(this, bHideCursorDuringCapture = false);

		SetupInputComponent();

		System::LogString("AuraPlayerController BeginPlay");
		ClickToMove = Cast<UClickToMove>(NewObject(this, UClickToMove::StaticClass()));
		ClickToMove.Ctor(this);

		OwnerCharacter = Cast<AAuraCharacter>(ControlledPawn);
	}

	UFUNCTION(BlueprintOverride)
	void Tick(float DeltaTime) {
		CursorTrace();
		// Client's ClickToMove will be null at the very beginning of the game.
		// That means the client's Tick() will be called before the BeginPlay(). I don't know why.
		if (ClickToMove != nullptr) {
			ClickToMove.Tick();
		}
	}

	void CursorTrace() {
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
		// if (LastEnemy == nullptr && ThisEnemy == nullptr) {
		// 	return;
		// }
		// if (LastEnemy != nullptr && ThisEnemy == nullptr) {
		// 	LastEnemy.Unhighlight();
		// }
		// if (LastEnemy == nullptr && ThisEnemy != nullptr) {
		// 	ThisEnemy.Highlight();
		// }
		// if (LastEnemy != nullptr && ThisEnemy != nullptr) {
		// 	if (LastEnemy != ThisEnemy) {
		// 		LastEnemy.Unhighlight();
		// 		ThisEnemy.Highlight();
		// 	}
		// }

		if (ThisEnemy != LastEnemy) {
			if (LastEnemy != nullptr) {
				LastEnemy.Unhighlight();
			}
			if (ThisEnemy != nullptr) {
				ThisEnemy.Highlight();
			}
			OwnerCharacter.SetAttackTarget(ThisEnemy);
		}
	}

	bool IsTargeting() {
		return ThisEnemy != nullptr;
	}

	bool CanCastFireBolt() {
		return IsTargeting() || bShiftPressed;
	}

	void SetupInputComponent() {
		UActorComponent InputComponent = GetComponentByClass(UEnhancedInputComponent::StaticClass());
		if (InputComponent == nullptr) {
			return; // server doesn't have input component
		}

		UEnhancedInputComponent EnhancedInput = Cast<UEnhancedInputComponent>(InputComponent);
		// WASD Move
		EnhancedInput.BindAction(MoveAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"Move"));
		// Shift
		EnhancedInput.BindAction(ShiftAction, ETriggerEvent::Started, FEnhancedInputActionHandlerDynamicSignature(this, n"OnShiftPressed"));
		EnhancedInput.BindAction(ShiftAction, ETriggerEvent::Completed, FEnhancedInputActionHandlerDynamicSignature(this, n"OnShiftReleased"));

		for (auto Element : SDataUtil::GetSDataMgr().InputMap) {
			UInputAction InputAction = Element.Key;
			EnhancedInput.BindAction(InputAction, ETriggerEvent::Started, FEnhancedInputActionHandlerDynamicSignature(this, n"OnSDataInputStarted"), );
			EnhancedInput.BindAction(InputAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"OnSDataInputTriggered"), );
			EnhancedInput.BindAction(InputAction, ETriggerEvent::Completed, FEnhancedInputActionHandlerDynamicSignature(this, n"OnSDataInputCompleted"), );
		}
	}

	UFUNCTION()
	void Move(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction) {
		ClickToMove.StopAutoRun();
		FRotator ControllerRotation = GetControlRotation();
		ControllerRotation.Pitch = 0.f;
		ControllerRotation.Roll = 0.f;
		FVector ControllerForwardVector = ControllerRotation.GetForwardVector();
		FVector ControllerRightVector = ControllerRotation.GetRightVector();

		APawn MyControlledPawn = GetControlledPawn();
		MyControlledPawn.AddMovementInput(ControllerForwardVector, ActionValue.Axis2D.Y);
		MyControlledPawn.AddMovementInput(ControllerRightVector, ActionValue.Axis2D.X);
	}

	UFUNCTION() // Pressed
	void OnSDataInputStarted(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction) {
		UAbilitySystemComponent ASC = GetASC();
		if (ASC == nullptr) {
			return;
		}

		FSDataInput Input = SDataUtil::GetSDataMgr().InputMap[SourceAction];
		if (ClickToMove.NeedTakeOverInput(Input.GameplayTag)) {
			ClickToMove.ClickPressed();
		} else {
			// 不能在这里一直给，而是在初始化时只给一次
			// TSubclassOf<UGameplayAbility> GameplayAbility = Input.AbilityClass;
			// if (GameplayAbility != nullptr) {
			// 	FGameplayAbilitySpec AbilitySpec = GasUtil::MakeAbilitySpec(GameplayAbility);
			// 	AbilitySpec.DynamicAbilityTags.AddTag(Input.GameplayTag);
			// 	ASC.GiveAbility(AbilitySpec);
			// }
		}
	}

	UFUNCTION() // Held
	void OnSDataInputTriggered(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction) {
		UAbilitySystemComponent ASC = GetASC();
		if (ASC == nullptr) {
			return;
		}

		// It's ok to put this below the ASC check, because ASC is only null when the player is not controlling a character.
		FSDataInput Input = SDataUtil::GetSDataMgr().InputMap[SourceAction];
		if (ClickToMove.NeedTakeOverInput(Input.GameplayTag)) {
			ClickToMove.ClickHeld();
		} else {
			/*
				Warning: Can't iterate ActivatableAbilities in Angelscript!
				Because it's key property `Items` is not exposed to blueprints.
				- ASC.ActivatableAbilities.Items;
				- ASC.GetActivatableAbilities();
			*/
			// ASC.TryActivateAbilityByClass(Input.AbilityClass);

			// TODO: 优化两次 for 循环（提PR解决）
			// TArray<FGameplayAbilitySpecHandle> OutAbilityHandles;
			// ASC.GetAllAbilities(OutAbilityHandles);
			// for (FGameplayAbilitySpecHandle AbilitySpecHandle : OutAbilityHandles) {
			// 	FGameplayAbilitySpec OuterAbilitySpec;
			// 	if (ASC.FindAbilitySpecFromHandle(AbilitySpecHandle, OuterAbilitySpec)) {
			// 		if (!OuterAbilitySpec.IsActive()) {
			// 			ASC.TryActivateAbility(OuterAbilitySpec.Handle);
			// 		}
			// 	}
			// }

			FGameplayAbilitySpec OutSpec;
			if (ASC.FindAbilitySpecFromClass(Input.AbilityClass, OutSpec)) {
				if (!OutSpec.IsActive()) {
					ASC.TryActivateAbility(OutSpec.Handle);
				}
			}
		}
	}

	UFUNCTION() // Released
	void OnSDataInputCompleted(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction) const {
		// Print(f"OnSDataInputCompleted {SourceAction.GetName()} Released");
		FSDataInput Input = SDataUtil::GetSDataMgr().InputMap[SourceAction];
		if (ClickToMove.NeedTakeOverInput(Input.GameplayTag)) {
			ClickToMove.ClickReleased();
		}
	}

	UAbilitySystemComponent GetASC() {
		if (AbilitySystemComponent == nullptr) {
			AbilitySystemComponent = AbilitySystem::GetAbilitySystemComponent(GetControlledPawn());
		}
		return AbilitySystemComponent;
	}

	UFUNCTION()
	void OnShiftPressed(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction) {
		bShiftPressed = true;
	}

	UFUNCTION()
	void OnShiftReleased(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction) {
		bShiftPressed = false;
	}
}
