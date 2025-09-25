extends Node2D

# func func_name(parameter1, parameter2, ..., parameterN) -> 
func _init() -> void:
	print("Game is initialized!")

func _enter_tree() -> void:
	print("Game entered the tree!")

func _ready() -> void:
	print("Game is ready!")
