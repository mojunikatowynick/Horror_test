extends Node

var mesh_owner: MeshInstance3D
var _rotate_show_tem: bool = false
@export var mouse_sensitivity: float = 0.09

func _ready() -> void:
	mesh_owner = get_parent()
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _physics_process(_delta: float) -> void:
	_control_show_item()

func _control_show_item() -> void:
	if Input.is_action_pressed("LMB"):
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		_rotate_show_tem = true
	else :
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		_rotate_show_tem = false

func _input(event:InputEvent) -> void:
	if _rotate_show_tem:
		var _mouse_input: = event is InputEventMouseMotion
		if _mouse_input:
			mesh_owner.rotate(Vector3(event.relative.y, event.relative.x, 0.0).normalized(),  mouse_sensitivity)
