extends Node3D

@export_enum("FPS contreoller", "IZO controller") var Controller_type: String
@onready var player_fps := preload("res://player.tscn")
@onready var player_izo := preload("res://player_2.tscn")
@onready var instance: Node3D
@export var player_parent : Node3D
@export var camera_izo : Camera3D

var player: CharacterBody3D

func _ready() -> void:
	match Controller_type:
		"FPS contreoller":
			instance = player_fps.instantiate()
			player_parent.add_child(instance)
		"IZO controller":
			instance = player_izo.instantiate()
			player_parent.add_child(instance)

	player = player_parent.get_child(0)

func _physics_process(_delta: float) -> void:
	camera_izo.look_at(player.global_position)
