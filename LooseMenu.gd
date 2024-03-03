extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LostButton.connect("pressed", self, "_on_LostButton_pressed")
	GameManager.connect("loose_game", self, "_on_GameManager_loose_game")

func _on_LostButton_pressed():
	$LostButton.disabled = true
	get_tree().paused = false
	GameManager.reload_game()

func _on_GameManager_loose_game():
	appear()


func appear():
	$AnimationPlayer.play("appear")
