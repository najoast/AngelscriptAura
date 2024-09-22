
# 受击时在 Victim 头顶显示伤害数字

思路：
- 创建一个 Widget
- 通过 WidgetComponent 在 Victim 的头顶上显示

具体步骤：
1. 创建 WBP_FloatText，里面只有一个 Text 控件
2. 给 WBP_FloatText 添加一个上浮的动画，并逐渐消失
3. 从 UWidgetComponent 派生一个子类 BP_FloatText, 在这里设置 WidgetClass 为 WBP_FloatText
4. 代码里：每次显示时，动态创建一个 BP_FloatText, 然后：

在 C++ 里：
- 调用 RegisterComponent 注册
- 调用 AttachToComponent 把它挂到 TargetCharacter 的 RootComponent 上
- 调用 DetachFromComponent 把它从 TargetCharacter 的 RootComponent 上拉开（先Attach再Detach的目的是为了设置 WidgetComponent 的位置）
- 设置 DamageText 的 DamageText

```c++
void AAuraPlayerController::ShowDamageNumber_Implementation(float DamageAmount,  ACharacter* TargetCharacter)
{
	if (IsValid(TargetCharacter) && DamageTextComponentClass)
	{
		UDamageTextComponent* DamageText = NewObject<UDamageTextComponent>(TargetCharacter, DamageTextComponentClass);
		DamageText->RegisterComponent();
		DamageText->AttachToComponent(TargetCharacter->GetRootComponent(), FAttachmentTransformRules::KeepRelativeTransform);
		DamageText->DetachFromComponent(FDetachmentTransformRules::KeepWorldTransform);
		DamageText->SetDamageText(DamageAmount);
	}
}
```

在 AS 里：
```c++
// class AAuraCharacterBase
void ShowDamageNumber(float DamageAmount, FLinearColor DamageColor = FLinearColor::White)
{
	UWidgetComponent DamageComponent = this.CreateComponent(DamageComponentClass);
	UAUW_FloatText AUW_FloatText = Cast<UAUW_FloatText>(DamageComponent.GetWidget());
	if (AUW_FloatText == nullptr) {
		return;
	}

	AUW_FloatText.Ctor(this);
	AUW_FloatText.OwnerWidgetComponent = DamageComponent;
	AUW_FloatText.Text_FloatText.SetText(FText::AsNumber(DamageAmount, FNumberFormattingOptions()));
	AUW_FloatText.Text_FloatText.SetColorAndOpacity(DamageColor);

	DamageComponent.AttachToComponent(GetRootComponent(), NAME_None, EAttachmentRule::KeepRelative);
	DamageComponent.DetachFromComponent(EDetachmentRule::KeepWorld);
}
```

遇到的坑：
- AS 里没有 RegisterComponent，最后翻遍了代码，找到了 CreateComponent
- BP_FloatText 是必须要创建的派生类，一开始直接在代码里用 UWidgetComponent，再动态创建 WBP_FloatText，行不通
	- 当然这里也有可能是因为我没有设置 Space = Screen 啊，我后面创建了 BP_FloatText 后在编辑器里发现了这个选项，想起来上次这里就被坑过，所以顺手就把这个选项设置了，反正后面都正常了，也不知道能不能不派生 BP_FloatText。我猜过去还是不行的，因为提前设置 Widget Class 这一步，代码里应该是有很多初始化工作要做的，动态创建 Widget 需要自己去调那成吨的接口来达到同样的效果。
- 上面说的，WidgetComponent 的 Space 一定要设置为 Screen，否则不显示！
