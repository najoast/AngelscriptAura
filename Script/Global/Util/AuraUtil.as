
namespace AuraUtil
{
	UAuraGameInstanceSubsystem GameInstance()
	{
		return UAuraGameInstanceSubsystem::Get();
	}

	USDataMgr GetSDataMgr()
	{
		return GameInstance().SDataMgr;
	}

	UGasModule GetCharacterGasModule(AAuraCharacterBase Character)
	{
		return Character.GasModule;
		// return Cast<UPlayerGasModule>(Character.PlayerModuleMgr.GetPlayerModule(EPlayerModule::Gas));
	}
}