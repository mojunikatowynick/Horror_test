class_name Player
extends CharacterBody3D

const  SPEED: float = 5.0
const  JUMP_VELOCITY := 4.5

@export_category("Basic Player information")
@export var acceleration: float = 0.1
@export var deceleration: float = 0.25
@export var top_anim_speed: float
@export var jump_move_damp := 2
@export var sprint_multi := 1.8
@export_range(5, 10,0.1) var crouch_speed: float = 7.0
@export var mouse_sensitivity: float = 0.5
@export var tilt_lower_limit : = deg_to_rad(-90.0)
@export var tilt_upper_limit : = deg_to_rad(90.0)
@export var camera_controller : Node
@export var camera_fps : Camera3D
@export var animator : AnimationPlayer
@export var crouch_shape_cast : ShapeCast3D

var _mouse_input: bool = false
var _mouse_rotation: Vector3
var _rotation_input: float
var _tilt_input: float
var _player_rotation: Vector3
var _camera_rotation: Vector3
var _current_rotation: float
var mouse_drag: float = 1.0
var _is_crouching: bool = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	camera_fps.make_current()

func _physics_process(delta: float) -> void:
	update_input()
	move_and_slide()
	_update_camera(delta)

		# Add the gravity. PLAYER_CONTROLER: CharacterBody3D
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func update_input() -> void:
		# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerp(velocity.x, direction.x * SPEED, acceleration)
		velocity.z = lerp(velocity.z, direction.z * SPEED, acceleration)
	else:
		#breaking speed from current vel to standstill "0" in time speed: change speed to fraction (0.1) for slowly slowing down
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func _unhandled_input(event:InputEvent) -> void:
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x * mouse_sensitivity * mouse_drag
		_tilt_input = -event.relative.y * mouse_sensitivity * mouse_drag

## jump
	if Input.is_action_just_pressed("Jump"):
		velocity.y = JUMP_VELOCITY

## crouch
	if Input.is_action_just_pressed("Crouch") and is_on_floor():
		_is_crouching = true
		animator.play("Crouch", 1.0, crouch_speed, false)

	if Input.is_action_just_released("Crouch"):
		uncrouch()

func uncrouch() -> void:
	if crouch_shape_cast.is_colliding() == false and _is_crouching:
		animator.play("Crouch", -1.0, -crouch_speed, true)
		_is_crouching = false
	elif crouch_shape_cast.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch()

func _update_camera(delta:float) -> void:
	_current_rotation = _rotation_input
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, tilt_lower_limit, tilt_upper_limit)
	_mouse_rotation.y += _rotation_input * delta

	_player_rotation = Vector3(0.0, _mouse_rotation.y, 0.0)
	_camera_rotation = Vector3(_mouse_rotation.x, 0.0, 0.0)

	camera_controller.transform.basis = Basis.from_euler(_camera_rotation)
	global_transform.basis = Basis.from_euler(_player_rotation)
	camera_controller.rotation.z = 0.0
	
	_rotation_input = 0.0
	_tilt_input = 0.0
