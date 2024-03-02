extends Node

func play_sfx(sound_path, volume_db = 0, pitch_scale = 1.0):
	var sfx = AudioStreamPlayer.new()
	sfx.stream = load(sound_path)
	sfx.volume_db = volume_db
	sfx.pitch_scale = pitch_scale
	add_child(sfx)
	sfx.play()
	sfx.connect("finished", sfx, "queue_free")  # Remove the player once the sound is done playing
	
	
func stop_all_sfx():
	# Iterate through all children of the AudioManager node.
	for child in get_children():
		# Check if the child is an AudioStreamPlayer (or its derivatives).
		if child is AudioStreamPlayer or child is AudioStreamPlayer2D or child is AudioStreamPlayer3D:
			child.stop()  # Stop the sound.
			child.queue_free()  # Optionally, remove the player after stopping.
