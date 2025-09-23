extends Node

var mesh_owner: MeshInstance3D
var _rotate_show_tem: bool = false
@export var mouse_sensitivity: float = 0.09
@export var zoom_speed: float = 0.2
var mesh_zoom: float = 0.0

func _ready() -> void:
	mesh_owner = get_parent()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _physics_process(_delta: float) -> void:
	_control_show_item()

	if Input.is_action_just_pressed("ZoomIn"):
		mesh_zoom = mesh_zoom + zoom_speed
	if Input.is_action_just_pressed("ZoomOut"):
		mesh_zoom -= zoom_speed

	mesh_zoom = clampf(mesh_zoom, 0.0, 2.2)
	mesh_owner.position.z = mesh_zoom


func _control_show_item() -> void:
	if Input.is_action_pressed("RMB"):
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		_rotate_show_tem = true
	else :
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		_rotate_show_tem = false

func _input(event:InputEvent) -> void:
	if _rotate_show_tem:
		var _mouse_input: = event is InputEventMouseMotion
		if _mouse_input:
			mesh_owner.rotate(Vector3(event.relative.y, event.relative.x, 1.0).normalized(),  mouse_sensitivity)
