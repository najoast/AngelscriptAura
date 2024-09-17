
class AAuraEnemy : AAuraCharacterBase
{
	// -------------------- Properties --------------------
	UPROPERTY(DefaultComponent)
	UWidgetComponent HealthBar;

	default CapsuleComponent.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);
	default CapsuleComponent.SetCollisionResponseToChannel(AuraEnum::ECC_Projectile, ECollisionResponse::ECR_Overlap);

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

}