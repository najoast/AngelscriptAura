# AutoRun
Script/Player/ClickToMove.as

```c++
void Tick()
{
	APawn ControlledPawn = OwnerController.GetControlledPawn();
	USplineComponent MovementSpline = OwnerController.MovementSpline;
	const FVector LocationOnSpline = MovementSpline.FindLocationClosestToWorldLocation(ControlledPawn.GetActorLocation(), ESplineCoordinateSpace::World);
	const FVector Direction = MovementSpline.FindDirectionClosestToWorldLocation(LocationOnSpline, ESplineCoordinateSpace::World);
	ControlledPawn.AddMovementInput(Direction);
}
```

主要就是两个接口的使用：
- FindLocationClosestToWorldLocation: 找到角色离这条曲线最近的位置，用于下一步计算方向
- FindDirectionClosestToWorldLocation: 找到曲线上某个点的方向（正切），使用该方向 AddMovementInput 即可实现移动

关于 AddMovementInput：
Add movement input along the given world direction vector (usually normalized) scaled by 'ScaleValue'. If ScaleValue < 0, movement will be in the opposite direction.
Base Pawn classes won't automatically apply movement, it's up to the user to do so in a Tick event. Subclasses such as Character and DefaultPawn automatically handle this input and move.

- WorldDirection - Direction in world space to apply input
- ScaleValue - Scale to apply to input. This can be used for analog input, ie a value of 0.5 applies half the normal value, while -1.0 would reverse the direction.
- bForce - If true always add the input, ignoring the result of IsMoveInputIgnored().

***

这里不得不给这个老师点赞，如果不用 Spline，也能做出来，但是会比较僵硬，在转弯时方向会突变。
使用这个曲线很优雅的解决了这个问题，而且给未来类似需求提供了很好的思路。比如：
- 想做一个按曲线运动的摄像机来做运镜
- 太空射击游戏，从屏幕四周随机出现敌人，可以在屏幕周围放一个 Spline，然后随机取点

# Allow Client Side Navigation
Project Settings > Engine > Navigation System > Allow Client Side Navigation

这个不设置，在多人模式下客户端无法使用寻路系统。
