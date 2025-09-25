extends CharacterBody2D

func _init() -> void:
	print("Character is initialized!")

func _enter_tree() -> void:
	print("Character entered the tree!")

func _ready() -> void:
	print("Character is ready!")

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func _exit_tree() -> void:
	pass
