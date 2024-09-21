
Ticker 是一个不同于 Timer 的定时器，它可以设定一个每帧执行的回调函数：
```cpp
void FTickerDelegate(float DeltaTime, float Percent, ETickerFuncType FuncType, TArray<UObject> Params);
```

- `DeltaTime`: 距离上一帧的时间
- `Percent`: 当前帧在持续时间内的百分比
- `FuncType`: 回调函数类型
- `Params`: 回调函数参数

Ticker 由 TickMgr 管理，创建方法：
```cpp
int32 CreateTicker(float Duration, FTickerDelegate OnTick, ETickerFuncType FuncType = 0, TArray<UObject> Params = TArray<UObject>())
```

返回的是 Ticker 的 ID，可以用来删除 Ticker。

删除方法：
```cpp
bool RemoveTicker(int32 TickerID)
```
返回是否删除成功。

具体实现在 `TickerMgr.as` 文件内。

***

Example:

```cpp
class AAuraCharacterBase : AAngelscriptGASCharacter
{
	UFUNCTION()
	private void Dissolve()
	{
		FSDataCharacter SDataCharacter = AuraUtil::GetSDataMgr().CharacterMap[CharacterID];
		if (System::IsValid(SDataCharacter.DissolveMaterial)) {
			UMaterialInstanceDynamic MID_Dissolve = Material::CreateDynamicMaterialInstance(SDataCharacter.DissolveMaterial);
			Mesh.SetMaterial(0, MID_Dissolve);
			AuraUtil::GameInstance().TickerMgr.CreateTicker(DISSOLVE_TIME, FTickerDelegate(this, n"DissolveTick"), ETickerFuncType::BodyDissolve);
		}
		if (System::IsValid(SDataCharacter.WeaponDissolveMaterial)) {
			UMaterialInstanceDynamic MID_WeaponDissolve = Material::CreateDynamicMaterialInstance(SDataCharacter.WeaponDissolveMaterial);
			Weapon.SetMaterial(0, MID_WeaponDissolve);
			AuraUtil::GameInstance().TickerMgr.CreateTicker(DISSOLVE_TIME, FTickerDelegate(this, n"DissolveTick"), ETickerFuncType::WeaponDissolve);
		}
	}

	UFUNCTION()
	private void DissolveTick(float DeltaTime, float Percent, ETickerFuncType FuncType, TArray<UObject> Params)
	{
		if (FuncType == ETickerFuncType::BodyDissolve) {
			Mesh.SetScalarParameterValueOnMaterials(n"Dissolve", Percent);
		} else if (FuncType == ETickerFuncType::WeaponDissolve) {
			Weapon.SetScalarParameterValueOnMaterials(n"Dissolve", Percent);
		}
	}
}
```
