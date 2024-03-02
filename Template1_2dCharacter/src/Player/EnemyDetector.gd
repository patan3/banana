extends Area2D

signal enemy_collected

var collected_enemies: Array

export var is_active: bool = false setget set_is_active

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered", self, "_on_EnemyDetector_area_entered")

func _on_EnemyDetector_area_entered(area: Area2D):
	if area.is_in_group("enemies"):
		emit_signal("enemy_collected")
		collected_enemies.append(area)


func set_is_active(value: bool):
	is_active = value
	get_node("CollisionShape2D").set_deferred("disabled", not value)
