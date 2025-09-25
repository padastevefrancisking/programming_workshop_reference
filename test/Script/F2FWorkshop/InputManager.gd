extends Node2D

func _init() -> void:
	print("Node2D is initialized!")

func _enter_tree() -> void:
	print("Node2D has entered scene!")

func _ready() -> void:
	print("Node2D is ready!")

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass

func _exit_tree() -> void:
	print("Game has exited scene!")
