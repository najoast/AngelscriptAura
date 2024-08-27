
class AAuraEnemy : AAuraCharacterBase
{
	default Mesh.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);

	void Highlight() {
		Mesh.RenderCustomDepth = true;
		Weapon.RenderCustomDepth = true;
	}

	void Unhighlight() {
		Mesh.RenderCustomDepth = false;
		Weapon.RenderCustomDepth = false;
	}

	// UFUNCTION(BlueprintOverride)
	// void Tick(float DeltaTime)
	// {
	// 	if (IsHighlight) {
	// 		System::DrawDebugSphere(GetActorLocation(), 50, 12, FLinearColor::Red);
	// 	}
	// }
}