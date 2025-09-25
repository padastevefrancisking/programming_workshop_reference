extends CharacterBody2D

@export var SPEED := 100.0
@export var JUMP_VELOCITY := -400.0

@onready var sprite := $Sprite2D as Sprite2D

var mousePos := position
var rotational_speed := 2

# Function - an instruction / set of instructions, exp(), pow(), printf(), abs()
# 1. Built-in function: readily available in programming language or libraries
# 2. User-defined functions: functions implemented by the user 

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		mousePos = get_global_mouse_position()
	
func check_rotation_flip(rotation_radians):
	if abs(rotation_radians) >= PI/2:
		sprite.flip_v = true
	else: 
		sprite.flip_v = false

func adjust_character(direction, delta):
	rotation += rotational_speed * direction * delta
	velocity = transform.x * Input.get_axis("move_up", "move_down") * SPEED

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	adjust_character(direction, delta)
	move_and_slide()


		
