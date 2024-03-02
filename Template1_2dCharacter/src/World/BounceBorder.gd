extends Area2D

export var bounce_direction: Vector2

func _ready():
	connect("body_entered", self, "_on_BounceBorder_body_entered")

func _on_BounceBorder_body_entered(body: Node):
	if body.name == "Player":
		body.emit_signal("bounce", bounce_direction)
