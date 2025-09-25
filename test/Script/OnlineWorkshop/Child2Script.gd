extends Node2D


func _init() -> void:
	print("Child2 is initialized!")

func _enter_tree() -> void:
	print("Child2 entered the tree!")

func _ready() -> void:
	print("Child2 is ready!")
