// Aura is a namespace for global functions in the Aura project
namespace Aura {
	// Can't work!
	// 结论：动态创建地板不可行，因为创建之后 NavMesh 全没了，无法点击地面自动行走。在 Editor 里创建后会自动编译 NavMesh。
	//      表现上也不对，只有第一次启动编辑器时，动态创建的地板才能被渲染出来，之后再启动游戏就不行了。
	// 240913 Update: 动态创建后，选中复制，然后停掉游戏，在 Editor 里粘贴，可行！
	void FloorTiler(UObject Outer, int Radius, int TileSizeX, int TileSizeY) {
		for (int i = -Radius; i < Radius; i++) {
			for (int j = -Radius; j < Radius; j++) {
				FVector Location(i * TileSizeX, j * TileSizeY, 0);
				FName ActorName = FName(f"FloorTile_{i}_{j}");
				AStaticMeshActor Actor = Cast<AStaticMeshActor>(SpawnActor(AStaticMeshActor::StaticClass(), Location, FRotator::ZeroRotator, ActorName, true));
				Actor.StaticMeshComponent.SetStaticMesh(Cast<UStaticMesh>(LoadObject(Outer, f"/Game/Assets/Dungeon/SM_Tile_3x3_A")));
				// FinishSpawningActor(Actor);
				// Actor.StaticMeshComponent.MarkRenderStateDirty();
				// Actor.StaticMeshComponent.SimulatePhysics = true;
				Print(f"FloorTile_{i}_{j} Created");
				// AStaticMeshActor Actor = Cast<AStaticMeshActor>(NewObject(Outer, AStaticMeshActor::StaticClass(), ));
				// Actor.StaticMeshComponent.StaticMesh = Cast<UStaticMesh>(LoadObject(Outer, f"/Game/Assets/Dungeon/SM_Tile_3x3_A"));
			}
		}
	}
}