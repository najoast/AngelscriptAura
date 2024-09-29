
class UPlayerModuleBase : UObject {
	UPlayerModuleMgr OwnerMgr;

	/* Because we need to use NewObject to create an object, there is no opportunity
	to pass parameters to the constructor of AS itself, so we change to manually call
	Ctor to simulate the construction process.
	*/
	void Ctor(UPlayerModuleMgr InOwnerMgr) {
		OwnerMgr = InOwnerMgr;
	}

	void Init() {
	}
}