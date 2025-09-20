extends StaticBody3D

@export var _mesh : MeshInstance3D 
var mesh_path: String

func _ready() -> void:
	mesh_path = _mesh.scene_file_path

func interact() -> void:
	MessageBus.interaction_item_show.emit(mesh_path)
	#print("INTERACTED")
