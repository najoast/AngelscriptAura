
class UPlayerModuleMgr : UObject
{
	private AAuraCharacter OwnerCharacter;
	private TMap<EPlayerModule, UPlayerModuleBase> PlayerModules;

	UPlayerModuleMgr(AAuraCharacter InOwnerCharacter)
	{
		OwnerCharacter = InOwnerCharacter;
		PlayerModules.Add(EPlayerModule::Gas, UPlayerGasModule(this));
	}

	AAuraCharacter GetOwnerCharacter()
	{
		return OwnerCharacter;
	}

	void Init()
	{
		for (auto Element : PlayerModules)
		{
			Element.Value.Init();
		}
	}
}