
namespace AuraUtil {
	UAuraGameInstanceSubsystem GameInstance() {
		return UAuraGameInstanceSubsystem::Get();
	}

	USDataMgr GetSDataMgr() {
		return GameInstance().SDataMgr;
	}

	UGasModule GetCharacterGasModule(AAuraCharacterBase Character) {
		return Character.GasModule;
		// return Cast<UPlayerGasModule>(Character.PlayerModuleMgr.GetPlayerModule(EPlayerModule::Gas));
	}

	// 使 PrimitiveComponent 模拟 Ragdoll 行为
	void RagdollComponent(UPrimitiveComponent Component) {
		Component.SetSimulatePhysics(true);
		Component.SetEnableGravity(true);
		Component.SetCollisionEnabled(ECollisionEnabled::PhysicsOnly);
		Component.SetCollisionResponseToChannel(ECollisionChannel::ECC_WorldStatic, ECollisionResponse::ECR_Block);
	}
}