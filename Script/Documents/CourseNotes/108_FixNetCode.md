# Fix Net Code
- AuraCharacterBase 加上了 bReplicates = true
	- 不确定这里有没有必要啊，我看原版是没加的
	- 翻了下 UE 的代码，在 Character.cpp 里也没看到默认是 true
	- 按我现在的理解，这里是应该加上的
- OnRep_ReplicationTrampoline 里有一处 Print 的错误，之前没开多人模式时因为不会调用到这里，所以一直没发现，改了就好了
- AuraPlayerController
	- 也加上了 bReplicates = true，这个原版 Aura 里就加了，所以应该是必须要加的
	- 在 SetupInputComponent 里，加上了对 InputComponent 的判空判断，因为在服务器上没有 InputComponent（服务器不需要直接处理玩家的输入）
	- `ClickToMove` 在 client 的 Tick 函数里有可能为 nullptr，但是过一会执行完 BeginPlay 函数后，这个值就会被赋值了。我不知道为什么会这样，只能在 Tick 里用判空判断来保证不会出错

# HitResult performance issue
这是个性能优化问题，之前要在 AuraPlayerController 里执行两次 GetHitResultUnderCursorByChannel，这个是很耗的一个函数，运算量比较大，同一帧里执行多次意义不大，优化为只调一次了。
以后其他业务要使用时，也可以统一使用这个的结果。甚至整个游戏范围内，每帧都只使用这一个。
