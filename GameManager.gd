extends Node

func _ready():
	start_game()

func start_game():
	print("Game Started!")
	get_tree().change_scene("res://StartMenu.tscn")
