extends Control

func _ready():
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")
	MusicManager.play_music("res://Template1_2dCharacter/src/AudioManager/Music/Banana.wav")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Template1_2dCharacter/src/Playground_pierre.tscn")
