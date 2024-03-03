extends Control

export var game_packed_scene: PackedScene

func _ready():
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Template1_2dCharacter/src/Playground_pierre_copy.tscn")
