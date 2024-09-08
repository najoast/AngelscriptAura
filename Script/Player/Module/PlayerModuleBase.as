
class UPlayerModuleBase : UObject
{
	UPlayerModuleMgr OwnerMgr;

	UPlayerModuleBase(UPlayerModuleMgr InOwnerMgr)
	{
		OwnerMgr = InOwnerMgr;
	}

	void Init()
	{
	}
}