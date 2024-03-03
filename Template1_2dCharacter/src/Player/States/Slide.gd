extends State
"""
Sliding movement on the ground.
Delegates movement to its parent Move state and extends it
with state transitions
"""

signal slide_started
signal slide_ended


onready var cooldown_timer: Timer = get_node("CooldownTimer")

export var slide_break_threashold: float = 0.5
export var slide_acceleration: float = 7
export var slide_friction: float = 2
export var max_speed_friction: Vector3 = Vector3(80.0, 0.0, 80.0)
export var initial_slide_push_factor: float = 1.2

func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	if event.is_action_pressed("slide"):
		_state_machine.transition_to("Move", { velocity = move.velocity })
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)
	if move.velocity.distance_to(Vector3.ZERO) < slide_break_threashold:
		_state_machine.transition_to("Move", { velocity = move.velocity })


func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	SfxManager.play_sfx("res://Template1_2dCharacter/src/AudioManager/SFX/splash_01.wav")
	move.enter(msg)
	emit_signal("slide_started")
	owner.set_collision_mask_bit(Globals.WORLD_LAYER, false)
#	owner.set_collision_mask_bit(Globals.ENEMIES_LAYER, false)
	owner.skin.play("run_naked")
	owner.enemy_detector.is_active = true
	
	move.can_move = false
	move.friction = slide_friction
	move.acceleration = slide_acceleration
	move.max_speed = max_speed_friction
	move.velocity += move.velocity * initial_slide_push_factor
#### Old code to take as reference ####
#	if "velocity" in msg:
#		move.velocity = msg.velocity 
#		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed.x)
#	if "impulse" in msg:
#		move.velocity += calculate_jump_velocity(msg.impulse)


func exit() -> void:
	var move: = get_parent()
	emit_signal("slide_ended")
	owner.enemy_detector.is_active = false
	
	move.can_move = true
	move.friction = move.friction_default
	move.acceleration = move.acceleration_default
	move.max_speed = move.max_speed_default
	cooldown_timer.start()
	
	owner.set_collision_mask_bit(Globals.WORLD_LAYER, true)
#	owner.set_collision_mask_bit(Globals.ENEMIES_LAYER, true)
	move.exit()

