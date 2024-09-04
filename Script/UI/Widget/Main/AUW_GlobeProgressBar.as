/*
1 影子进度条更新逻辑：
	1.1 当新的进度低于主进度时，主进度条跳到新进度，影子进度条缓慢更新到新进度
	1.2 当新的进度高于主进度时，影子进度条跳到新进度，主进度条缓慢更新到新进度
	1.3 主进度条 <= 影子进度，这条规则永远成立

2 如果在影子进度更新的过程中更新新进度，情况变得复杂起来了。有三种情况：
	2.1 新进度 < 主进度
		- 处理逻辑同 1.1
	2.2 新进度 >= 主进度 && 新进度 < 影子进度
		- 处理逻辑同 1.1
	2.3 新进度 >= 影子进度 && 新进度 < 主进度
		- 处理逻辑同 1.2
	2.4 新进度 >= 影子进度
		- 处理逻辑同 1.2
*/

class UAUW_GlobeProgressBar : UAuraUserWidget
{
	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Main;

	UPROPERTY(BindWidget)
	UProgressBar ProgressBar_Ghost;

	UPROPERTY(BindWidget)
	UTextBlock Text_Value;

	// -------------------------------------
	private float32 Value;
	private float32 MaxValue;
	private float32 Percent;
	private const float32 ChaseSpeed = 0.1f;

	void SetPercent(float32 NewValue, float32 NewMaxValue)
	{
		if (NewValue == Value && NewMaxValue == MaxValue) {
			return;
		}

		Value = NewValue;
		MaxValue = NewMaxValue;
		Percent = NewValue / MaxValue;

		Text_Value.SetText(FText::FromString(f"{Value :.0}/{MaxValue :.0}"));

		float32 NewPercent = NewValue / NewMaxValue;

		float32 MainPercent = ProgressBar_Main.Percent;
		float32 GhostPercent = ProgressBar_Ghost.Percent;

		if (NewPercent < MainPercent) {
			if (NewPercent < GhostPercent) {
				ProgressBar_Main.SetPercent(NewPercent);
			} else {
				check(false); // 这种情况不存在
			}
		} else {
			if (NewPercent > GhostPercent) {
				ProgressBar_Ghost.SetPercent(NewPercent);
			} else {
				ProgressBar_Main.SetPercent(NewPercent);
			}
		}
	}

	UFUNCTION(BlueprintOverride)
	void Tick(FGeometry MyGeometry, float InDeltaTime)
	{
		float32 MainPercent = ProgressBar_Main.Percent;
		float32 GhostPercent = ProgressBar_Ghost.Percent;

		if (MainPercent == GhostPercent && MainPercent == Percent) {
			return;
		}

		UProgressBar ChasingProgressBar = (MainPercent != Percent) ? ProgressBar_Main : ProgressBar_Ghost;
		float32 DeltePercent = ChaseSpeed * float32(InDeltaTime);
		if (ChasingProgressBar.Percent < Percent) {
			ChasingProgressBar.SetPercent(Math::Min(ChasingProgressBar.Percent + DeltePercent, Percent));
		} else {
			ChasingProgressBar.SetPercent(Math::Max(ChasingProgressBar.Percent - DeltePercent, Percent));
		}
	}

	UFUNCTION(BlueprintOverride)
	void OnMouseEnter(FGeometry MyGeometry, FPointerEvent MouseEvent)
	{
		Text_Value.SetVisibility(ESlateVisibility::Visible);
	}

	UFUNCTION(BlueprintOverride)
	void OnMouseLeave(FPointerEvent MouseEvent)
	{
		if (!MouseEvent.GetEffectingButton().IsValid()) {
			Text_Value.SetVisibility(ESlateVisibility::Collapsed);
		}
	}
}
