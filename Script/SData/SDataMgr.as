
class USDataMgr : UObject
{
	TMap<EItemID, FSDataItem> ItemMap;
	UDataTable SDataWidgetClass;
	TMap<UInputAction, FSDataInput> InputMap;

	void Init()
	{
		LoadItem();
		LoadWidgetClass();
		LoadInput();
	}

	private void LoadItem()
	{
		// Load /Script/Engine.DataTable'/Game/SData/DT_SData_Item.DT_SData_Item'
		UDataTable SDataItems = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_Item"));
		
		TArray<FSDataItem> AllItems;
		SDataItems.GetAllRows(AllItems);
		for (FSDataItem Item : AllItems) {
			ItemMap.Add(Item.ID, Item);
		}
	}

	private void LoadWidgetClass()
	{
		SDataWidgetClass = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_WidgetClass"));
	}

	private void LoadInput()
	{
		UDataTable SDataInput = Cast<UDataTable>(LoadObject(this, "/Game/SData/DT_SData_Input"));

		TArray<FSDataInput> AllInputs;
		SDataInput.GetAllRows(AllInputs);
		for (FSDataInput Input : AllInputs) {
			InputMap.Add(Input.InputAction, Input);
		}
	}
}
