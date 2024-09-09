
event void FOnItemPickedUp(EItemID ItemID);
event void FOnWidgetOpened(UUserWidget Widget);
event void FOnWidgetClosed(UUserWidget Widget);
event void FOnAttributeChanged(FAngelscriptModifiedAttribute AttributeChangeData);

class UAuraEventMgr : UObject
{
	FOnItemPickedUp OnItemPickedUpEvent;
	FOnWidgetOpened OnWidgetOpenedEvent;
	FOnWidgetClosed OnWidgetClosedEvent;
	FOnAttributeChanged OnAttributeChangedEvent;

	// void OnAttributeSetRegistered(UAngelscriptAttributeSet NewAttributeSet)
	// {
	// }
}