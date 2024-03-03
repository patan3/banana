extends Area

export var bounce_direction: Vector3

onready var col : StaticBody = get_node("StaticBody")

func _ready():
	connect("body_entered", self, "_on_BounceBorder_body_entered")
	if abs(bounce_direction.x) > 0.0:
		col.set_collision_mask_bit(1, false)

func _on_BounceBorder_body_entered(body: Node):
	if body.name == "Player":
		body.emit_signal("bounce", bounce_direction)
