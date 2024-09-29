
class UAGA_PlayerSpell : UAGA_SpellBase
{
	UFUNCTION(BlueprintOverride)
	void ActivateAbility() {
		Super::ActivateAbility();

		UAAT_TargetDataUnderMouse TargetDataUnderMouse = Cast<UAAT_TargetDataUnderMouse>(UAngelscriptAbilityTask::CreateAbilityTask(UAAT_TargetDataUnderMouse, this));
		TargetDataUnderMouse.OnMouseTargetData.BindUFunction(this, n"OnMouseTargetData");
		TargetDataUnderMouse.ReadyForActivation();
	}

	UFUNCTION()
	private void OnMouseTargetData(const FVector& Data) {
		TargetLocation = Data;
	}
}
