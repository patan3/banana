extends Node

const WORLD_LAYER: = 2
const ENEMIES_LAYER: = 1

signal enemy_collected(enemy_counter)
signal score_updated(score)
signal multipliers_resetted

var player_global_position

#### SCORE SYSTEM ####
var score: float = 0.0

var slide_points: float = 0.0
var slide_multiplier: float = 1.0
var final_slide_score: float = 0.0



func _ready():
	connect("enemy_collected", self, "_on_Globals_enemy_collected")

func _process(_delta):
	pass


func _on_Globals_enemy_collected(enemy_counter: float):
	calculate(enemy_counter)

func calculate(value: int, points: float = 50.0):
	if value > 0 and value < 2:
		slide_multiplier = 1.2
	elif value > 2 and value < 4:
		slide_multiplier = 1.3
	elif value > 5:
		slide_multiplier = 1.5
	slide_points = slide_points + points


func calculate_slide_points():
	final_slide_score = slide_points * slide_multiplier
	update_score(final_slide_score)

func update_score(new_score: float):
	score = score + new_score
	emit_signal("score_updated", score)
	reset_multiplier_points()

func reset_multiplier_points():
	slide_multiplier = 1.0
	slide_points = 0.0
	emit_signal("multipliers_resetted")
