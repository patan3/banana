extends Control

export var game_packed_scene: PackedScene

func _ready():
	$StartButton.connect("pressed", self, "_on_StartButton_pressed")
	MusicManager.play_music("res://Template1_2dCharacter/src/AudioManager/Music/banan_song_9mesures_105_bpm_part_01.wav")

func _on_StartButton_pressed():
	get_tree().change_scene("res://Template1_2dCharacter/src/Game.tscn")
	MusicManager.stop_music()
	MusicManager.play_music("res://Template1_2dCharacter/src/AudioManager/Music/banan_song_9mesures_137_bpm_part_02.wav")
