extends Node3D

@export var dark_light : OmniLight3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var distance : = dark_light.global_position - Global.Player.global_position
	if distance.length_squared() <= 5.0:
		var energy : float = remap(distance.length_squared(), 5.0, 1.0, 0.0, 5.0)
		dark_light.light_energy = energy
	else:
		dark_light.light_energy = lerp(dark_light.light_energy, 0.0, 0.2)
