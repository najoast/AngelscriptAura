
class USDataMgr : UObject
{
	TMap<EItemID, FSDataItem> ItemMap;

	UDataTable SDataWidgetClasses;

	void Init()
	{
		// Load /Script/Engine.DataTable'/Game/SData/DT_SData_Item.DT_SData_Item'
		UDataTable SDataItems = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_Item"));
		
		TArray<FSDataItem> AllItems;
		SDataItems.GetAllRows(AllItems);
		for (FSDataItem Item : AllItems) {
			ItemMap.Add(Item.ID, Item);
		}
		
		SDataWidgetClasses = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_WidgetClass"));
	}
}
