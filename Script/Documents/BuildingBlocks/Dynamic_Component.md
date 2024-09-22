
# C++
在 C++ 里，动态创建 UPrimitiveComponent 一般是使用 `CreateDefaultSubobject`，但这个接口只能在构造函数里使用，在其他函数里可以使用 `NewObject` + `RegisterComponent`。

# Angelscript
在 AS 里，没有导出 CreateDefaultSubobject 和 RegisterComponent 接口。可以使用 `AActor.CreateComponent`，这个是 Angelscript 专门导出的，在原版 UE 的 Blueprint 里并不存在。
（这是个 AActor 的 Mixin 函数）

因为是给 AActor 导出的，所以只能在 AActor 体系里使用，AActor/APawn/ACharacter 等……

具体可参考 `ShowDamageNumber` 函数。
