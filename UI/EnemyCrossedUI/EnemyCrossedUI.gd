extends Node2D

onready var label : Label = $EnemyCrossed

func _ready():
	GameManager.connect("enemy_crossed", self, "_on_enemy_crossed")

func _on_enemy_crossed():
	label.text = str(GameManager.enemies_crossed)
