
class UPlayerModuleMgr : UObject
{
	private AAuraCharacter OwnerCharacter;
	private TMap<EPlayerModule, UPlayerModuleBase> PlayerModules;

	void Ctor(AAuraCharacter InOwnerCharacter)
	{
		if (this.World == nullptr) {
			check(false);
		}
		OwnerCharacter = InOwnerCharacter;
		PlayerModules.Add(EPlayerModule::Gas, Cast<UPlayerModuleBase>(NewObject(this, UPlayerGasModule::StaticClass(), n"UPlayerGasModule")));

		for (auto Element : PlayerModules)
		{
			Element.Value.Ctor(this);
		}
	}

	UPlayerModuleBase GetPlayerModule(EPlayerModule Module)
	{
		return PlayerModules[Module];
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