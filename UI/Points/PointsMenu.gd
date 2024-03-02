tool
extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("enemy_collected", self, "_on_Globals_enemy_collected")
	Globals.connect("score_updated", self, "_on_Globals_score_updated")



#func _on_Globals_enemy_collected(enemy_counter: int):
#	for point_label in get_tree().get_nodes_in_group("point_labels"):
#		if point_label.name == "Multiplier":
#			point_label.text = str(Globals.slide_multiplier)
#			point_label.get_node("AnimationPlayer").play("appear")
#		elif point_label.name == "Points":
#			point_label.text = str(Globals.slide_points)
#			point_label.get_node("AnimationPlayer").play("appear")
#
func _on_Globals_score_updated(new_score: int):
	pass
#	get_node("Control/Score").text = str(new_score)
#	get_node("Control/Score/AnimationPlayer").play("appear")
