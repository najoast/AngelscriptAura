
import unreal

# Define the actor class you want to spawn
# actor_class_name = '/Game/AStaticMeshActor.AStaticMeshActor_C'
# actor_class = unreal.EditorAssetLibrary.load_blueprint_class(actor_class_name)

# void FloorTiler(UObject Outer, int Radius, int TileSizeX, int TileSizeY)
# {
# 	for (int i = -Radius; i < Radius; i++) {
# 		for (int j = -Radius; j < Radius; j++) {
# 			FVector Location(i * TileSizeX, j * TileSizeY, 0);
# 			FName ActorName = FName(f"FloorTile_{i}_{j}");
# 			AStaticMeshActor Actor = Cast<AStaticMeshActor>(SpawnActor(AStaticMeshActor::StaticClass(), Location, FRotator::ZeroRotator, ActorName, true));
# 			Actor.StaticMeshComponent.SetStaticMesh(Cast<UStaticMesh>(LoadObject(Outer, f"/Game/Assets/Dungeon/SM_Tile_3x3_A")));

def FloorTiler(Outer, Radius, TileSizeX, TileSizeY):
    for i in range(-Radius, Radius):
        for j in range(-Radius, Radius):
            Location = unreal.Vector(i * TileSizeX, j * TileSizeY, 0)
            ActorName = unreal.Name(f"FloorTile_{i}_{j}")
            Actor = unreal.EditorLevelLibrary.spawn_actor_from_class(unreal.AStaticMeshActor, Location, unreal.FRotator.zero_rotator, ActorName, True)
            Actor.static_mesh_component.set_static_mesh(unreal.EditorLevelLibrary.load_object(Outer, f"/Game/Assets/Dungeon/SM_Tile_3x3_A"))

# Call the function
FloorTiler(unreal.EditorLevelLibrary.get_editor_world_context().actor, 10, 600, 600)
