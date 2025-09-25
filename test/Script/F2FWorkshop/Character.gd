extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var rotational_speed = 3
var rotational_direction = 0

@onready var sprite : Sprite2D = $Sprite2D as Sprite2D

var target = position
	
func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		target = get_global_mouse_position()

func get_input():
	look_at(get_global_mouse_position())
	velocity = transform.x * Input.get_axis("move_down", "move_up") * SPEED
	
func _physics_process(delta: float) -> void:
	look_at(target)
	velocity = position.direction_to(target) * SPEED 
	if position.distance_to(target) > 10:
		move_and_slide()
