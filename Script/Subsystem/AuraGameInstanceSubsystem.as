/*
Usage:
	AuraUtil::GameInstance().SDataMgr.
*/

class UAuraGameInstanceSubsystem : UScriptGameInstanceSubsystem
{
	USDataMgr SDataMgr;
	UAuraEventMgr EventMgr;
	UTickerMgr TickerMgr;

	UFUNCTION(BlueprintOverride)
	void Initialize()
	{
		SDataMgr = Cast<USDataMgr>(NewObject(this, USDataMgr));
		EventMgr = Cast<UAuraEventMgr>(NewObject(this, UAuraEventMgr));
		TickerMgr = Cast<UTickerMgr>(NewObject(this, UTickerMgr));

		SDataMgr.Init();
		TickerMgr.Init();
	}

	UFUNCTION(BlueprintOverride)
	void Tick(float DeltaTime)
	{
		TickerMgr.Tick(DeltaTime);
	}
}
