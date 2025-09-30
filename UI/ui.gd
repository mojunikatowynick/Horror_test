extends CanvasLayer

var parent: Node3D
@export var pause_menu: Control
@export var show_menu: Control
@export var show_item_mesh_instat_place: Node3D
@onready var interactive_item_control : = preload("res://Script/interactive_control.tscn")
var _is_paused: bool = false

func _ready() -> void:
	parent = get_parent()
	pause_menu.visible = false
	show_menu.visible = false
	MessageBus.connect("interaction_item_show", _show_interaced_item)

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
	for child in show_item_mesh_instat_place.get_children():
		child.queue_free()

func _show_interaced_item(_show_mesh: String) -> void:
	pause()
	var temp_mesh := load(_show_mesh)
	var mesh_instance :MeshInstance3D = temp_mesh.instantiate()
	show_item_mesh_instat_place.add_child(mesh_instance)
	show_menu.visible = true
	var controller_instance : = interactive_item_control.instantiate()
	mesh_instance.add_child(controller_instance)
	if "activate" in mesh_instance:
		mesh_instance.activate()
