
namespace SDataUtil
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
		if (GetSDataMgr().SDataWidgetClass.FindRow(WidgetClassName, WidgetClass))
		{
			return WidgetClass.WidgetClass;
		}
		return nullptr;
	}

	// template <typename T>
	// TArray<T> GetAllRows(UDataTable DataTable)
	// {
	// 	TArray<T> AllRows;
	// 	DataTable.GetAllRows(AllRows);
	// 	return AllRows;
	// }
}