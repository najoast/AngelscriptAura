
AI 驱动 Enemy 移动时，在转向时会出现 Snapping 的问题（就是瞬间转向，没有过渡，显得不够平滑）。

解决这个问题很简单，不要使用 Controller 的转向，改用 Movement 组件的就好了。

设置步骤：
1. 打开 BP_EnemyBase 蓝图
2. 在 Components 里选中 Self，在 Details 里搜 Rotation, 取消勾选 Pwan 里的 Use Controller Rotation Yaw
3. 在 Components 里选中 Movement 组件，搜 Rotation，勾选 Use Controller Desired Rotation. (可以调整 Rotation Rate 的 Z 值来调整转向的速度，越快就越 Snapping，保持默认360就很好了)

```cpp
class AAuraEnemy : AAuraCharacterBase
{
	default bUseControllerRotationPitch = false;
	default bUseControllerRotationYaw = false;
	default bUseControllerRotationRoll = false;
	default CharacterMovement.bUseControllerDesiredRotation = true;
}
```
