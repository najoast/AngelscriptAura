
class UAUW_AttributeMenu : UAuraUserWidget
{
	UPROPERTY(BindWidget)
	UAUW_FramedValue WBP_AttributePoints;

	UPROPERTY(BindWidget)
	UListView ListView_PrimaryAttributes;

	UPROPERTY(BindWidget)
	UListView ListView_SecondaryAttributes;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Health;

	UPROPERTY(BindWidget)
	UTextBlock Text_Health;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Mana;

	UPROPERTY(BindWidget)
	UTextBlock Text_Mana;
}