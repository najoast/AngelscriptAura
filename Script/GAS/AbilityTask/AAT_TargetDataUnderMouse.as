
delegate void FMouseTargetDataSignature(const FVector& Data);

class UAAT_TargetDataUnderMouse : UAngelscriptAbilityTask
{
	UPROPERTY()
	FMouseTargetDataSignature OnMouseTargetData;

	UFUNCTION(BlueprintOverride)
	void Activate() {
		UAngelscriptAbilitySystemComponent ASC = Cast<UAngelscriptAbilitySystemComponent>(GetAbilitySystemComponent());
		if (ASC == nullptr) {
			return;
		}

		APlayerController PC = ASC.GetAbilityActorInfo().PlayerController;
		FHitResult HitResult;
		PC.GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, HitResult);
		if (!HitResult.bBlockingHit) {
			return;
		}
		OnMouseTargetData.Execute(HitResult.ImpactPoint);

		// if (IsLocallyControlled()) {
		// 	// client
		// 	// SendMouseTargetData();
		// } else {
		// 	// server
		// }
	}

	/*
		TODO: Multiplay support
		https://github.com/DruidMech/GameplayAbilitySystem_Aura/commit/a8c571f5206ab765263a79d31593764ce811739a
		https://github.com/DruidMech/GameplayAbilitySystem_Aura/commit/04b42850529345f1d8a59b0ad4b59887852a8130
		AS 里缺太多接口没导出了， 所以可能无法实现，已知未导出内容：
			- FScopedPredictionWindow
			- ServerSetReplicatedTargetData
	*/
	// void SendMouseTargetData()
	// {
	// 	UAngelscriptAbilitySystemComponent ASC = Cast<UAngelscriptAbilitySystemComponent>(GetAbilitySystemComponent());
	// 	if (ASC == nullptr) {
	// 		return;
	// 	}

	// 	APlayerController PC = ASC.GetAbilityActorInfo().PlayerController;
	// 	FHitResult HitResult;
	// 	PC.GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, HitResult);
	// 	if (!HitResult.bBlockingHit) {
	// 		return;
	// 	}
	// 	// OnMouseTargetData.Execute(HitResult.ImpactPoint);

	// 	// ------------ as try
	// 	FGameplayAbilityTargetDataHandle DataHandle = AbilitySystem::AbilityTargetDataFromHitResult(HitResult);
	// 	// ASC.Replicat
	// }
}
