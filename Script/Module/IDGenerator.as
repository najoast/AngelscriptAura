
/*
自增ID生成器：
1. 内部有个变量维护当前ID生成到哪了
2. 初始化时，可设置ID最大值，超过此最大值后从0开始
*/
class UIDGenerator : UObject
{
	private int32 CurrentID;
	private int32 MaxID;

	void Init(int32 InMaxID)
	{
		this.MaxID = InMaxID;
		this.CurrentID = 0;
	}

	int32 NextID()
	{
		if (CurrentID >= MaxID) {
			CurrentID = 0;
		}
		CurrentID++;
		return CurrentID;
	}
}
