extends Area2D

func _ready():
	connect("body_entered", self, "_on_BounceBorder_body_entered")

func _on_BounceBorder_body_entered(body: Node):
	if body.name == "Player":
		body.emit_signal("bounce")
