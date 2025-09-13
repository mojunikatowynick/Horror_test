extends RayCast3D

var interact_cast_result:Node3D
var current_cast_result:Node3D

func _input(event:InputEvent) -> void:
	if event.is_action_pressed("Interact"):
		interact(true)

func _physics_process(_delta:float) -> void:
	interact_cast()

# creating ray of lenght of 2m that checks for bodies if it is check if it is inteactable and allows to "e" use
func interact_cast() -> void:
	current_cast_result = get_collider()

	if current_cast_result != interact_cast_result:
		if interact_cast_result and interact_cast_result.has_user_signal("unfocused"):
			interact_cast_result.emit_signal("unfocused")
		interact_cast_result = current_cast_result
		if interact_cast_result and interact_cast_result.has_user_signal("focused"):
			interact_cast_result.emit_signal("focused")
	
	if get_collider() == null:
		interact(false)
	#
	#print(interact_cast_result)
	
func interact(can_interact: bool) -> void:
	if can_interact:
		if interact_cast_result and interact_cast_result.has_user_signal("interacted"):
			interact_cast_result.emit_signal("interacted")
