
namespace AuraUtil
{
	UAuraGameInstanceSubsystem GameInstance()
	{
		return UAuraGameInstanceSubsystem::Get();
	}

	UGasModule GetPlayerGasModule(AAuraCharacter Character)
	{
		return Character.GasModule;
		// return Cast<UPlayerGasModule>(Character.PlayerModuleMgr.GetPlayerModule(EPlayerModule::Gas));
	}
}