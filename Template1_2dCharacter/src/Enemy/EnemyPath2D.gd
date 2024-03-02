extends Path2D

onready var enemy_tmp: Area2D = get_node("PathFollow2D/EnemyTmp")
onready var path_follow_2d: PathFollow2D = get_node("PathFollow2D")

export var path_percentage_array: PoolRealArray
export var time_duration_array: PoolRealArray

var unit_offset_tween: SceneTreeTween 

func _ready():
	path_follow_2d.unit_offset = 0.0
	enemy_tmp.connect("player_entered", self, "_on_EnemyTmp_player_entered")

func _input(event):
	if event.is_action("debug"):
		tween_unit_offset(choose(path_percentage_array), choose(time_duration_array), 2)

func tween_unit_offset(path_percentage: float, time_duration: float, ease_type: int = 0):
#	EaseType EASE_IN = 0
#	EaseType EASE_OUT = 1
#	EaseType EASE_IN_OUT = 2
#	EaseType EASE_OUT_IN = 3
	unit_offset_tween = create_tween()
	unit_offset_tween.connect("finished", self, "_on_Tween_position_tween")
	unit_offset_tween.tween_property(path_follow_2d, 'unit_offset', path_percentage, time_duration).as_relative().set_trans(Tween.TRANS_EXPO).set_ease(ease_type)

func _on_Tween_position_tween():
	pass

func _on_EnemyTmp_player_entered():
	print("Body entered in    " + str(self))
	unit_offset_tween.stop()
	set_process(false)

func choose(array):
	randomize()
	return array[randi() % array.size()]
