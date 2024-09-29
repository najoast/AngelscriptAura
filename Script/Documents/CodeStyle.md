# Code Style

### 1. Each class is divided into three areas, separated by the following annotations. If a certain area does not exist, the corresponding dividing line can be omitted.

```cpp
class Xxx {
	// -------------------- Properties --------------------
	// -------------------- Varibles --------------------
	// -------------------- Functions --------------------
}
```

### 2. Use Golang's `{` style
```cpp
class AAuraCharacterBase : ACharacter {
	UFUNCTION(BlueprintOverride)
	void BeginPlay() {
		if (condition1) {
			DoSomething1();
		} else if (condition2) {
			DoSomething2();
		} else {
			DoSomethingElse();
		}

		for (int i = 0; i < 10; i++) {
			DoSomething(i);
		}
	}
}

```

