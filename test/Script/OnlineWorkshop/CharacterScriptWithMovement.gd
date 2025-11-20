extends CharacterBody2D

enum State {
	IDLE,
	WALK,
	JUMP,
	DOUBLE_JUMP,
	ROLL
}

var state_names = ["Idle", "Walk", "Jump", "Double Jump", "Roll"]

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
const ROTATIONAL_SPEED = 3
const ROLL_SPEED = 300
const ROLL_DURATION = 0.5
const ROLL_COOLDOWN = 3.00

var has_double_jumped : bool = false
var mouse_position = position
var current_state : State = State.IDLE

var current_direction: int
var last_faced_direction: int
var roll_time_left: float
var roll_cooldown_left: float = 0.0

# variables: snake_case_example_1
# functions (userDefined): camelCaseExample2
# constants: SCREAMING_CASE_EXAMPLE_3

@onready var sprite := $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	match current_state:
		State.IDLE:
			play_idle_logic(delta)
		State.WALK:
			play_walk_logic(delta)
		State.JUMP:
			play_jump_logic(delta)
		State.DOUBLE_JUMP:
			play_double_jump_logic(delta)
		State.ROLL:
			play_roll_logic(delta)
	
	move_and_slide()

func _process(delta: float) -> void:
	# MOUSE-BASED 
	# velocity = position.direction_to(mouse_position) * SPEED
	
	# look_at(mouse_position)
	# checkRotation(rotation_degrees)
	# if position.distance_to(mouse_position) > 10:
	#	move_and_slide()
	
		
	# PLATFORMER
	current_direction = Input.get_axis("move_left", "move_right")
	match current_state:
		State.IDLE:
			play_idle_animation(delta)
		State.WALK:
			play_walk_animation(delta)
		State.JUMP:
			play_jump_animation(delta)
		State.DOUBLE_JUMP:
			play_double_jump_animation(delta)
		State.ROLL:
			play_roll_animation(delta)
	
	move_and_slide()
	# TOPDOWN
	# var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	# velocity = direction * SPEED
	
	# VEHICULAR
	# var direction = Input.get_axis("move_down", "move_up")
	# velocity = transform.x * direction * SPEED
	 
	# var rotational_direction = Input.get_axis("move_left", "move_right")
	# rotation += rotational_direction * ROTATIONAL_SPEED * delta

func play_idle_logic(delta: float):
	roll_cooldown_left = max(roll_cooldown_left - delta, 0)
	
	if (Input.is_action_just_pressed("move_up") and is_on_floor()):
		velocity.y = JUMP_VELOCITY
		current_state = State.JUMP
		return
	
	if not is_on_floor():
		current_state = State.JUMP
		return
	
	if current_direction != 0:
		current_state = State.WALK
		return
	
	velocity.x = 0

func play_walk_logic(delta: float):
	roll_cooldown_left = max(roll_cooldown_left - delta, 0)
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		current_state = State.JUMP
		return
	
	if current_direction == 0:
		current_state = State.IDLE
		return
	
	if Input.is_action_just_pressed("roll") and roll_cooldown_left == 0:
		roll_time_left = ROLL_DURATION
		roll_cooldown_left = ROLL_COOLDOWN
		current_state = State.ROLL
		return
		
	velocity.x = SPEED * current_direction
	last_faced_direction = current_direction
	
func play_jump_logic(delta: float):
	roll_cooldown_left = max(roll_cooldown_left - delta, 0)
	
	if is_on_floor():
		if current_direction != 0:
			current_state = State.WALK
			return
		else:
			current_state = State.IDLE
			return
	
	if Input.is_action_just_pressed("move_up"):
		velocity.y = JUMP_VELOCITY
		current_state = State.DOUBLE_JUMP
		return
	
	if Input.is_action_just_pressed("roll") and roll_cooldown_left == 0:
		roll_time_left = ROLL_DURATION
		roll_cooldown_left = ROLL_COOLDOWN
		current_state = State.ROLL
		return
	
	velocity += get_gravity() * delta
	velocity.x = SPEED * current_direction
	last_faced_direction = current_direction

func play_double_jump_logic(delta: float):
	roll_cooldown_left = max(roll_cooldown_left - delta, 0)
	
	if is_on_floor():
		if current_direction != 0:
			current_state = State.WALK
			return
		else:
			current_state = State.IDLE
			return
			
	if Input.is_action_just_pressed("roll") and roll_cooldown_left == 0:
		roll_time_left = ROLL_DURATION
		roll_cooldown_left = ROLL_COOLDOWN
		current_state = State.ROLL
		return
		
	velocity += get_gravity() * delta
	velocity.x = SPEED * current_direction
	last_faced_direction = current_direction

func play_roll_logic(delta:float):
	roll_time_left = max(roll_time_left - delta, 0)
	roll_cooldown_left = max(roll_cooldown_left - delta, 0)
	
	velocity.x = ROLL_SPEED * last_faced_direction
	velocity.y = 0
	
	if roll_time_left == 0:
		if not is_on_floor():
			current_state = State.JUMP
			return
		
		if current_direction == 0:
			current_state = State.IDLE
			return
		else:
			current_state = State.WALK
			return
	
	
func play_idle_animation(delta: float):
	sprite.flip_h = last_faced_direction < 0
	sprite.play("idle")

func play_walk_animation(delta: float):
	sprite.flip_h = current_direction < 0
	sprite.play("walk")

func play_jump_animation(delta: float):
	sprite.flip_h = current_direction < 0
	
	if velocity.y > 0:
		sprite.play("fall")
	else:
		sprite.play("jump")
	
func play_double_jump_animation(delta: float):
	sprite.flip_h = current_direction < 0
	
	if velocity.y > 0:
		sprite.play("fall")
	else:
		sprite.play("jump")

func play_roll_animation(delta: float):
	sprite.flip_h = last_faced_direction < 0
	sprite.play("roll")
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		mouse_position = get_global_mouse_position()

func checkRotation(rotation_degrees: float) -> void:
	# Check if rotation is beyond 90 and -90
	print(rotation_degrees)
	if rotation_degrees > 90.0 or rotation_degrees < -90.0:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
