extends KinematicBody

signal player_entered

var direction

onready var _initial_position: = global_transform.origin

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var skin: MeshInstance = get_node("Position3D/elvis/elvis")
onready var redTimer: Timer = get_node("RednessTimer")

export var is_active: bool = true setget set_is_active

func _ready():
	animation_player.connect("animation_finished", self, "_on_AnimationPlayer_animation_finished")


func _physics_process(delta):
	pass
	#skin.material_overlay


func _on_AnimationPlayer_animation_finished(anim_name: String):
	if anim_name == "flip":
		queue_free()


func set_is_active(value: bool):
	is_active = value
	get_node("CollisionShape2D").set_deferred("disabled", not value)


func kill():
	animation_player.play("flip")
	emit_signal("player_entered")
	set_is_active(false)
