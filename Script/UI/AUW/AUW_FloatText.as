
class UAUW_FloatText : UAuraUserWidget {
	UPROPERTY(BindWidget)
	UTextBlock Text_FloatText;

	UPROPERTY(Transient, Meta = (BindWidgetAnim), NotEditable)
	protected UWidgetAnimation Anim_Float;

	UWidgetComponent OwnerWidgetComponent;

	void OnCtor() override {
		if (Anim_Float != nullptr) {
			PlayAnimation(Anim_Float);
		}
	}

	UFUNCTION(BlueprintOverride)
	void OnAnimationFinished(const UWidgetAnimation Animation) {
		if (Animation == Anim_Float) {
			// 这个调不调应该都不影响，下面删除 DamageComponent 组件后应该会自动删除
			// 保险起见，还是手动调一下
			RemoveFromParent();
			// 动画播完后删除 DamageComponent 组件，否则会有内存泄漏
			OwnerWidgetComponent.DestroyComponent(OwnerCharacter);
		}
	}

}