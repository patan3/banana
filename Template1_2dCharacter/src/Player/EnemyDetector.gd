extends Area

signal enemy_collected

export var is_active: bool = false setget set_is_active

var can_chain_bonus: bool = false
var enemy_counter: int = 0
var multiplier: float  = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_on_EnemyDetector_body_entered")
	owner.get_node("StateMachine/Move/Slide").connect("slide_started", self, "_on_Slide_slide_started")
	owner.get_node("StateMachine/Move/Slide").connect("slide_ended", self, "_on_Slide_slide_ended")


func _on_EnemyDetector_body_entered(body: Node):
	if body.is_in_group("enemies"):
		enemy_counter += 1
		Globals.emit_signal("enemy_collected", enemy_counter)
		emit_signal("enemy_collected")
		body.kill()


func _on_Slide_slide_started():
	print("slide started")
	enemy_counter = 0

func _on_Slide_slide_ended():
	print("slide ended")
	Globals.calculate_slide_points()


func set_is_active(value: bool):
	is_active = value
	get_node("Collision").set_disabled(not value)



