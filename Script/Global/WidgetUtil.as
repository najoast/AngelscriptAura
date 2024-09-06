
namespace WidgetUtil
{
	event void OnWidgetOpened(UUserWidget Widget);
	event void OnWidgetClosed(TSubclassOf<UUserWidget> WidgetClass);

	// delegate void PreOpenWidgetDelegate(UUserWidget Widget);

	UUserWidget OpenWidget(FName WidgetClassName, APlayerController PlayerController, FVector2D Position = FVector2D::ZeroVector)
	{
		TSubclassOf<UUserWidget> WidgetClass = SData::GetWidgetClass(WidgetClassName);
		if (WidgetClass == nullptr) {
			Print(f"Widget {WidgetClassName} is not found");
			return nullptr;
		}
		UUserWidget UserWidget = WidgetBlueprint::CreateWidget(WidgetClass, PlayerController);
		if (UserWidget == nullptr) {
			Print(f"Failed to create UserWidget {WidgetClassName}");
			return nullptr;
		}

		if (Position != FVector2D::ZeroVector) {
			UserWidget.SetPositionInViewport(Position);
		}
		UserWidget.AddToViewport();
		return UserWidget;
	}

	void CloseWidget(UUserWidget Widget)
	{
		// Widget.RemoveFromViewport();
	}

	// Get the position of the viewport by the given position ratio
	FVector2D GetViewportPositionByRatio(APlayerController PlayerController, float32 PositionRatio)
	{
		int SizeX = 0, SizeY = 0;
		PlayerController.GetViewportSize(SizeX, SizeY);
		return FVector2D(float(SizeX)*PositionRatio, float(SizeY)*PositionRatio);
	}
}