
namespace AuraUtil
{
	UAuraGameInstanceSubsystem GameInstance()
	{
		return UAuraGameInstanceSubsystem::Get();
	}

	UGasModule GetCharacterGasModule(AAuraCharacterBase Character)
	{
		return Character.GasModule;
		// return Cast<UPlayerGasModule>(Character.PlayerModuleMgr.GetPlayerModule(EPlayerModule::Gas));
	}
}