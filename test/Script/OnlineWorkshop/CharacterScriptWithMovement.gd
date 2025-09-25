extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var x_position = Input.get_axis("move_left", "move_right")
	velocity.x = SPEED * x_position
		
	move_and_slide()
