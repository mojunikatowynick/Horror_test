extends Node3D

@export_enum("FPS contreoller", "IZO controller") var Controller_type: String
@onready var player_fps := preload("res://player.tscn")
@onready var player_izo := preload("res://player_2.tscn")
@onready var instance: Node3D
@export var player_parent : Node3D
@onready var roof := $house/CSGCombiner3D/roof
@onready var outsidewall_1 := $house/outsidewall1
@onready var outsidewall_2 := $house/outsidewall2

@export var camera_izo : Camera3D

func _ready() -> void:

	match Controller_type:
		"FPS contreoller":
			instance = player_fps.instantiate()
			player_parent.add_child(instance)
			roof.visible = true
			outsidewall_1.visible = true
			outsidewall_2.visible = true
		"IZO controller":
			instance = player_izo.instantiate()
			player_parent.add_child(instance)
			camera_izo.make_current()
			roof.visible = false
			outsidewall_1.visible = false
			outsidewall_2.visible = false
