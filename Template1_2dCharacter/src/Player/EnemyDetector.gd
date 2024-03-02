extends Area2D

var enemy_collected: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_on_EnemyDetector_area_entered")

func _on_EnemyDetector_area_entered(area: Area2D):
	if area.is_in_group("enemies"):
#		area.follow_player_position(true)
		enemy_collected.append(area)
