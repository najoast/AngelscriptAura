
/*
- DeltaTime: 距离上一帧的时间
- Percent: 当前帧在持续时间内的百分比
- FuncType: 回调函数类型
- Params: 回调函数参数
*/
delegate void FTickerDelegate(float DeltaTime, float Percent, ETickerFuncType FuncType, TArray<UObject> Params);

struct FTicker
{
	int32 ID;
	float ElapsedTime;
	float Duration;
	FTickerDelegate OnTick;
	ETickerFuncType FuncType;
	TArray<UObject> Params;
}

class UTickerMgr : UObject
{
	private TMap<int32, FTicker> Tickers;
	private TArray<int32> ToBeRemovedTickers; // Can't remove TMap element during iteration.
	private UIDGenerator IDGenerator;

	void Init()
	{
		IDGenerator = Cast<UIDGenerator>(NewObject(this, UIDGenerator));
		IDGenerator.Init(MAX_int32);
	}

	int32 CreateTicker(float Duration, FTickerDelegate OnTick, ETickerFuncType FuncType = 0, TArray<UObject> Params = TArray<UObject>())
	{
		FTicker Ticker;
		Ticker.ID = IDGenerator.NextID();
		Ticker.ElapsedTime = 0;
		Ticker.Duration = Duration;
		Ticker.OnTick = OnTick;
		Ticker.FuncType = FuncType;
		Ticker.Params = Params;
		Tickers.Add(Ticker.ID, Ticker);
		return Ticker.ID;
	}

	bool RemoveTicker(int32 TickerID)
	{
		if (Tickers.Contains(TickerID)) {
			Tickers.Remove(TickerID);
			return true;
		}
		return false;
	}

	void Tick(float DeltaTime)
	{
		if (Tickers.Num() == 0) {
			return;
		}

		for (auto Element : Tickers) {
			FTicker& Ticker = Element.Value;
			Ticker.ElapsedTime += DeltaTime;
			if (Ticker.OnTick.IsBound()) {
				float Percent = Math::Clamp(Ticker.ElapsedTime / Ticker.Duration, 0, 1);
				Print(f"Ticker {DeltaTime} {Ticker.ElapsedTime} {Ticker.Duration} {Percent}");
				Ticker.OnTick.Execute(DeltaTime, Percent, Ticker.FuncType, Ticker.Params);
			}

			if (Ticker.ElapsedTime >= Ticker.Duration) {
				ToBeRemovedTickers.Add(Ticker.ID);
			}
		}

		for (int32 ToBeRemovedTickerID : ToBeRemovedTickers) {
			Tickers.Remove(ToBeRemovedTickerID);
		}
		ToBeRemovedTickers.Empty();
	}
}
