extends MeshInstance3D

@export var area_1 : Area3D 

func activate() -> void:
	area_1.input_ray_pickable = true

func deactivate() -> void:
	area_1.input_ray_pickable = false

func _on_area_3d_mouse_entered() -> void:
	print("mouse entered")
