extends Node

onready var score_label: Label = get_node("VBoxContainer/Score")

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("enemy_collected", self, "_on_Globals_enemy_collected")
	Globals.connect("score_updated", self, "_on_Globals_score_updated")
	Globals.connect("multipliers_resetted", self, "_on_Globals_multipliers_resetted")


func _on_Globals_enemy_collected(enemy_counter: int):
	pass
#	update_multiplier_labels(Globals.slide_multiplier, Globals.slide_points)

func _on_Globals_score_updated(new_score: int):
	pass
#	score_label.text = str(new_score)
#	score_label.get_node("AnimationPlayer").play("rotate")

func _on_Globals_multipliers_resetted():\
	pass
#	update_multiplier_labels(1.0, 0.0)


func update_multiplier_labels(multiplier_value: float, slide_points_value: float):
	for point_label in get_tree().get_nodes_in_group("point_labels"):
		if point_label.name == "Multiplier":
			point_label.text = str(multiplier_value)
		elif point_label.name == "SlidePoints":
			point_label.text = str(slide_points_value)
		point_label.get_node("AnimationPlayer").play("appear")
