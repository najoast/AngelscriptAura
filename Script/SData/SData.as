
namespace SData
{
	USDataMgr GetSDataMgr()
	{
		UAuraGameInstanceSubsystem Subsystem = UAuraGameInstanceSubsystem::Get();
		return Subsystem.SDataMgr;
	}

	FSDataItem GetItem(EItemID ItemID)
	{
		return GetSDataMgr().ItemMap[ItemID];
	}

	TSubclassOf<UUserWidget> GetWidgetClass(FName WidgetClassName)
	{
		FSDataWidgetClass WidgetClass;
		if (GetSDataMgr().SDataWidgetClasses.FindRow(WidgetClassName, WidgetClass))
		{
			return WidgetClass.WidgetClass;
		}
		return nullptr;
	}
}