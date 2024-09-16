
class AAuraEnemy : AAuraCharacterBase
{
	default CapsuleComponent.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);
	default CapsuleComponent.SetCollisionResponseToChannel(AuraEnum::ECC_Projectile, ECollisionResponse::ECR_Overlap);

	void Highlight() {
		Mesh.RenderCustomDepth = true;
		Weapon.RenderCustomDepth = true;
	}

	void Unhighlight() {
		Mesh.RenderCustomDepth = false;
		Weapon.RenderCustomDepth = false;
	}

}