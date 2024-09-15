
delegate void FMouseTargetDataSignature(const FVector& Data);

class UAAT_TargetDataUnderMouse : UAngelscriptAbilityTask
{
	UPROPERTY()
	FMouseTargetDataSignature OnMouseTargetData;

	UFUNCTION(BlueprintOverride)
	void Activate()
	{
		UAngelscriptAbilitySystemComponent ASC = Cast<UAngelscriptAbilitySystemComponent>(GetAbilitySystemComponent());
		if (ASC != nullptr) {
			APlayerController PC = ASC.GetAbilityActorInfo().PlayerController;
			FHitResult HitResult;
			PC.GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, HitResult);
			if (HitResult.bBlockingHit) {
				OnMouseTargetData.Execute(HitResult.ImpactPoint);
			}
		}
	}
}
