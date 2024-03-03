extends KinematicBody
class_name Player

signal bounce

onready var state_machine: StateMachine = $StateMachine
onready var skin: = $Skin
onready var enemy_detector: Area = $EnemyDetector

onready var collider: CollisionShape = $CollisionShape2D


const FLOOR_NORMAL: = Vector3.UP

var is_active: = true setget set_is_active

var is_falling: = false 


func set_is_active(value: bool) -> void:
	is_active = value
	if not collider:
		return
	collider.disabled = not value

func _physics_process(_delta):
	print(state_machine.state.name)
	Globals.player_global_position = global_transform.origin

