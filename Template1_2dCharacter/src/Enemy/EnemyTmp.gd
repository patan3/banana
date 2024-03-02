extends Area2D

signal player_entered

export var speed = Vector2(400,400)

onready var _initial_position: = global_position

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


export var is_active: bool = true setget set_is_active

func _ready():
	connect("area_entered", self, "_on_EnemyTmp_area_entered")
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")


func _physics_process(delta):
	position += _initial_position + speed * delta


func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "flip":
		queue_free()

func _on_EnemyTmp_area_entered(area: Area2D):
	if area.name == "EnemyDetector":
		emit_signal("player_entered")
		is_active = false

func set_is_active(value: bool):
	is_active = value
	get_node("CollisionShape2D").set_deferred("disabled", not value)
