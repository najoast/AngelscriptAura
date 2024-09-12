/*
Usage:
	AuraUtil::GameInstance().SDataMgr.
*/

class UAuraGameInstanceSubsystem : UScriptGameInstanceSubsystem
{
	USDataMgr SDataMgr = USDataMgr();
	UAuraEventMgr EventMgr = UAuraEventMgr();

	UFUNCTION(BlueprintOverride)
	void Initialize()
	{
		// Print("MyGame World Subsystem Initialized!");
		SDataMgr.Init();
		// Aura::FloorTiler(this, 1, 600, 600);
	}

	// UFUNCTION(BlueprintOverride)
	// void Tick(float DeltaTime)
	// {
	//     Print("Tick");
	// }
}
