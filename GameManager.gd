extends Node

export var max_enemies_crossed: int = 1


signal enemy_crossed
signal loose_game

var enemies_crossed: int = 0

func _input(event):
	if event.is_action_pressed("debug"):
		emit_signal("enemy_crossed")

func _ready():
	start_game()
	connect("enemy_crossed", self, "_on_GameManager_enemy_crossed")

func start_game():
	print("Game Started!")
	reset_stats()
	get_tree().change_scene("res://StartMenu.tscn")


func _on_GameManager_enemy_crossed():
	enemies_crossed += 1
	if enemies_crossed >= max_enemies_crossed:
		emit_signal("loose_game")
		get_tree().paused = true

func reset_stats():
	enemies_crossed = 0
	Globals.score = 0

func reload_game():
	reset_stats()
	get_tree().change_scene("res://StartMenu.tscn")



