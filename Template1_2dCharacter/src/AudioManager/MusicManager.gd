extends Node

func play_music(sound_path, volume_db = 0, pitch_scale = 1.0):
	var music = AudioStreamPlayer.new()
	music.stream = load(sound_path)
	music.volume_db = volume_db
	music.autoplay = true
	music.pitch_scale = pitch_scale
	add_child(music)
	music.play()
	music.connect("finished", music, "queue_free")  # Remove the player once the sound is done playing
	
	
func stop_music():
	# Iterate through all children of the AudioManager node.
	for child in get_children():
		# Check if the child is an AudioStreamPlayer (or its derivatives).
		if child is AudioStreamPlayer or child is AudioStreamPlayer2D or child is AudioStreamPlayer3D:
			child.stop()  # Stop the sound.
			child.queue_free()  # Optionally, remove the player after stopping.
