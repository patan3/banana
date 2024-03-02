extends Area2D

signal player_entered


onready var _initial_position: = global_position

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


export var is_active: bool = true setget set_is_active
export var speed_h_array: PoolRealArray

var speed: Vector2

func _ready():
	connect("area_entered", self, "_on_EnemyTmp_area_entered")
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")
	speed.y = 0.0
	speed.x = Utils.choose(speed_h_array)


func _physics_process(delta):
	position +=  speed * delta


func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "flip":
		queue_free()

func _on_EnemyTmp_area_entered(area: Area2D):
	if area.name == "EnemyDetector":
		animation_player.play("flip")
		emit_signal("player_entered")
		set_is_active(false)

func set_is_active(value: bool):
	is_active = value
	get_node("CollisionShape2D").set_deferred("disabled", not value)
