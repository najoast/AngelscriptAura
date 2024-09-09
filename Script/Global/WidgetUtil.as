
namespace WidgetUtil
{
	event void OnWidgetOpened(UUserWidget Widget);
	event void OnWidgetClosed(TSubclassOf<UUserWidget> WidgetClass);

	// delegate void PreOpenWidgetDelegate(UUserWidget Widget);

	UUserWidget OpenWidgetByClass(TSubclassOf<UUserWidget> WidgetClass, AAuraCharacter AuraCharacter, FVector2D Position = FVector2D::ZeroVector)
	{
		UUserWidget UserWidget = WidgetBlueprint::CreateWidget(WidgetClass, AuraCharacter.GetLocalViewingPlayerController());
		if (UserWidget == nullptr) {
			Print(f"Failed to create UserWidget {WidgetClass}");
			return nullptr;
		}

		UAuraUserWidget AuraUserWidget = Cast<UAuraUserWidget>(UserWidget);
		if (AuraUserWidget != nullptr) {
			AuraUserWidget.Ctor(AuraCharacter);
		}

		if (Position != FVector2D::ZeroVector) {
			UserWidget.SetPositionInViewport(Position);
		}
		UserWidget.AddToViewport();
		AuraUtil::GameInstance().EventMgr.OnWidgetOpenedEvent.Broadcast(UserWidget);
		return UserWidget;
	}

	UUserWidget OpenWidget(FName WidgetClassName, AAuraCharacter AuraCharacter, FVector2D Position = FVector2D::ZeroVector)
	{
		TSubclassOf<UUserWidget> WidgetClass = SData::GetWidgetClass(WidgetClassName);
		if (WidgetClass == nullptr) {
			Print(f"Widget {WidgetClassName} is not found");
			return nullptr;
		}
		return OpenWidgetByClass(WidgetClass, AuraCharacter, Position);
	}

	void CloseWidget(UUserWidget UserWidget)
	{
		AuraUtil::GameInstance().EventMgr.OnWidgetClosedEvent.Broadcast(UserWidget);
		UserWidget.RemoveFromParent();
	}

	// Get the position of the viewport by the given position ratio
	FVector2D GetViewportPositionByRatio(APlayerController PlayerController, float32 PositionRatio)
	{
		int SizeX = 0, SizeY = 0;
		PlayerController.GetViewportSize(SizeX, SizeY);
		return FVector2D(float(SizeX)*PositionRatio, float(SizeY)*PositionRatio);
	}
}