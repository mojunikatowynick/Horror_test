extends CanvasLayer

var parent: Node3D
@export var pause_menu: Control
@export var show_menu: Control
@export var show_item_mesh_instat_place: Node3D

var _is_paused: bool = false

func _ready() -> void:
	parent = get_parent()
	pause_menu.visible = false
	show_menu.visible = false
	MessageBus.connect("interaction_item_show", _show_item)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if _is_paused:
			resume()
		else: 
			pause()

func pause() -> void:
	pause_menu.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_is_paused = true

func resume() -> void:
	pause_menu.visible = false
	get_tree().paused = false
	if parent.Controller_type == "FPS contreoller":
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_is_paused = false
	show_menu.visible = false

func _show_item(_show_mesh: String) -> void:
	pause()
	var temp_mesh := load(_show_mesh)
	var instance :MeshInstance3D = temp_mesh.instantiate()
	show_item_mesh_instat_place.add_child(instance)
	show_menu.visible = true
