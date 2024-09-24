
class AAuraEnemy : AAuraCharacterBase
{
	// -------------------- Properties --------------------
	UPROPERTY(DefaultComponent)
	UWidgetComponent HealthBar;

	UPROPERTY()
	UBehaviorTree BehaviorTree;

	default CapsuleComponent.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);
	default CapsuleComponent.SetCollisionResponseToChannel(AuraEnum::ECC_Projectile, ECollisionResponse::ECR_Overlap);
	default Tags.Add(AuraConst::EnemyTag);
	// default CharacterMovement.MaxSpeed = 120;

	// -------------------- Variables --------------------

	// -------------------- Functions --------------------
	void OnAttributeChanged(const FAngelscriptModifiedAttribute&in AttributeChangeData) override
	{
		if (AttributeChangeData.Name == AuraAttributes::Health) {
			// HealthBar.ProgressBar_HealthBar.SetPercent(AttributeChangeData.NewValue / AttributeChangeData.BaseValue);
			UAUW_HealthBar HealthBarWidget = Cast<UAUW_HealthBar>(HealthBar.GetWidget());
			if (HealthBarWidget != nullptr) {
				HealthBarWidget.SetPercent(GasModule.GetAttributeValue(AuraAttributes::Health), GasModule.GetAttributeValue(AuraAttributes::MaxHealth));
			}
		}
	}

	UFUNCTION(BlueprintOverride)
	void BeginPlay()
	{
		Super::BeginPlay();

		HealthBar.AttachToComponent(GetRootComponent());
		UAUW_HealthBar HealthBarWidget = Cast<UAUW_HealthBar>(HealthBar.GetWidget());
		if (HealthBarWidget != nullptr) {
			HealthBarWidget.OwnerCharacter = this;
			// HealthBarWidget.ProgressBar_HealthBar.SetPercent(1);
		}

		AbilitySystem.OnOwnedTagUpdated.AddUFunction(this, n"OnOwnedTagUpdated");
	}

	void Highlight()
	{
		Mesh.RenderCustomDepth = true;
		Weapon.RenderCustomDepth = true;
	}

	void Unhighlight()
	{
		Mesh.RenderCustomDepth = false;
		Weapon.RenderCustomDepth = false;
	}

	UFUNCTION()
	private void OnOwnedTagUpdated(const FGameplayTag&in Tag, bool TagExists)
	{
		Print(f"OnOwnedTagUpdated: {Tag.ToString() =} {TagExists =}");
	}

	UFUNCTION(BlueprintOverride)
	void Possessed(AController NewController)
	{
		if (HasAuthority()) {
			AAuraAIController AIController = Cast<AAuraAIController>(GetController());
			if (AIController != nullptr) {
				AIController.RunBehaviorTree(BehaviorTree);
			}
		}
	}
}
