
event void FOnItemPickedUp(EItemID ItemID);
event void FOnWidgetOpened(UUserWidget Widget);
event void FOnWidgetClosed(UUserWidget Widget);

class UAuraEventMgr : UObject
{
	FOnItemPickedUp OnItemPickedUpEvent;
	FOnWidgetOpened OnWidgetOpenedEvent;
	FOnWidgetClosed OnWidgetClosedEvent;
}