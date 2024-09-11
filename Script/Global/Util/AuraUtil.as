
namespace AuraUtil
{
	UAuraGameInstanceSubsystem GameInstance()
	{
		return UAuraGameInstanceSubsystem::Get();
	}

	UPlayerGasModule GetPlayerGasModule(AAuraCharacter Character)
	{
		return Cast<UPlayerGasModule>(Character.PlayerModuleMgr.GetPlayerModule(EPlayerModule::Gas));
	}
}