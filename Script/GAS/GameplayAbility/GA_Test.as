
class UGA_Test : UAuraGameplayAbility {
	UFUNCTION(BlueprintOverride)
	void ActivateAbility() {
		Print("ActivateAbility");

		System::SetTimer(this, n"Test", 1.0f, false);
	}

	UFUNCTION(BlueprintOverride)
	void OnEndAbility(bool bWasCancelled) {
		Print(f"Test Ability Ended: {bWasCancelled =}");
	}

	UFUNCTION()
	void Test() {
		Print("Test Latent Called");
		EndAbility();
	}
}
