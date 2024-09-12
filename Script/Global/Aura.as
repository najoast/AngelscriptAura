// Aura is a namespace for global functions in the Aura project
namespace Aura
{
	// Can't work!
	void FloorTiler(UObject Outer, int Radius, int TileSizeX, int TileSizeY)
	{
		UWorld World = Outer.GetWorld();
		check(World != nullptr);

		for (int i = -Radius; i < Radius; i++) {
			for (int j = -Radius; j < Radius; j++) {
				FVector Location(i * TileSizeX, j * TileSizeY, 0);
				AStaticMeshActor Actor = Cast<AStaticMeshActor>(SpawnActor(AStaticMeshActor::StaticClass(), Location, FRotator::ZeroRotator, FName(f"FloorTile_{i}_{j}"), true));
				Actor.StaticMeshComponent.SetStaticMesh(Cast<UStaticMesh>(LoadObject(Outer, f"/Game/Assets/Dungeon/SM_Tile_3x3_A")));
				Actor.StaticMeshComponent.SimulatePhysics = true;
				Print(f"FloorTile_{i}_{j} Created");
				// AStaticMeshActor Actor = Cast<AStaticMeshActor>(NewObject(Outer, AStaticMeshActor::StaticClass(), ));
				// Actor.StaticMeshComponent.StaticMesh = Cast<UStaticMesh>(LoadObject(Outer, f"/Game/Assets/Dungeon/SM_Tile_3x3_A"));
			}
		}
	}
}