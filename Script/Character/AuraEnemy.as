
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

}