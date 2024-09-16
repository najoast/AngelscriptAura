# Code Style

### 1. Each class is divided into three areas, separated by the following annotations. If a certain area does not exist, the corresponding dividing line can be omitted.

```cpp
class Xxx
{
	// -------------------- Properties --------------------
	// -------------------- Varibles --------------------
	// -------------------- Functions --------------------
}
```

### 2. Except for the `{` on the right side of class and function, the rest are not wrapped
```cpp
class Xxx
{
	void SomeFunction()
	{
		if (true) {
			DoSomething();
		} else {
			DoSomethingElse();
		}

		while (true) {
			DoSomething();
		}

		for (int i = 0; i < 10; i++) {
			DoSomething();
		}
	}
}

```

# TODO
- [x] WidgetEvent
	- [x] Open Widget
	- [x] Close Widget
- [x] When `UAUW_AttributeMenu` closed, the `WBP_WideButton_Attributes` should be enabled
- [x] Fix WBP_Button click issue
- [x] Player Module

