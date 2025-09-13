extends CharacterBody3D


const SPEED := 5
@export var friction := 0.2
@export var acceleration := 0.1
@export var deceleration: float = 0.25
const JUMP_VELOCITY = 4.5

func _physics_process(delta : float) -> void:
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, acceleration)
		velocity.z = lerp(velocity.z, direction.z * SPEED, acceleration)
		rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10)
	else:
		#breaking speed from current vel to standstill "0" in time speed: change speed to fraction (0.1) for slowly slowing down
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)
	move_and_slide()

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
