extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ROTATIONAL_SPEED = 3

var has_double_jumped = false
var mouse_position = position

@onready var sprite := $Sprite2D

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		mouse_position = get_global_mouse_position()

func check_rotation(rotation_degrees: float) -> void:
	# Check if rotation is beyond 90 and -90
	print(rotation_degrees)
	if rotation_degrees > 90.0 or rotation_degrees < -90.0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false

func _physics_process(delta: float) -> void:
	# MOUSE-BASED 
	velocity = position.direction_to(mouse_position) * SPEED
	
	look_at(mouse_position)
	check_rotation(rotation_degrees)
	if position.distance_to(mouse_position) > 10:
		move_and_slide()
		
	# PLATFORMER
	# if not is_on_floor():
	#	velocity += get_gravity() * delta
	#	if Input.is_action_just_pressed("move_up") and not has_double_jumped:
	#		velocity.y = JUMP_VELOCITY
	#		has_double_jumped = true
	#
	# if is_on_floor():
	#	has_double_jumped = false
	#
	# if Input.is_action_just_pressed("move_up") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	#
	# var x_position = Input.get_axis("move_left", "move_right")
	# velocity.x = SPEED * x_position
	
	# TOPDOWN
	# var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# velocity = direction * SPEED
	
	# VEHICULAR
	# var direction = Input.get_axis("move_down", "move_up")
	# velocity = transform.x * direction * SPEED
	 
	# var rotational_direction = Input.get_axis("move_left", "move_right")
	# rotation += rotational_direction * ROTATIONAL_SPEED * delta
