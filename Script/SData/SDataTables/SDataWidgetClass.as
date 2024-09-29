
// 这张表放一些 WBP_Xxx 蓝图类，用于在代码里动态创建 UUserWidget 对象
USTRUCT()
struct FSDataWidgetClass {
	UPROPERTY()
	TSubclassOf<UUserWidget> WidgetClass;
}
