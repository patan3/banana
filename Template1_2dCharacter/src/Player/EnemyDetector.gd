extends Area2D

signal enemy_collected

var collected_enemies: Array

export var is_active: bool = false setget set_is_active


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_EnemyDetector_body_entered")


func _on_EnemyDetector_body_entered(body: Node):
	if body.is_in_group("enemies"):
		collected_enemies.append(body)
		emit_signal("enemy_collected")
		body.kill()


func set_is_active(value: bool):
	is_active = value
	get_node("CollisionShape2D").set_deferred("disabled", not value)
