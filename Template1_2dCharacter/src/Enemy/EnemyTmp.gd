extends Area2D

signal player_entered

export var speed = Vector2(400,400)


export var is_active: bool = true setget set_is_active

func _ready():
	connect("body_entered", self, "_on_EnemyTmp_body_entered")


func _physics_process(delta):
	position += speed * delta



func _on_EnemyTmp_body_entered(body: Node):
	if body.name == "Player":
		emit_signal("player_entered")
		is_active = false

func set_is_active(value: bool):
	is_active = value
	get_node("CollisionShape2D").set_deferred("disabled", not value)
