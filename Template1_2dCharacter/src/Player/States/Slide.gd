extends State
"""
Sliding movement on the ground.
Delegates movement to its parent Move state and extends it
with state transitions
"""

export var slide_friction: float = 0.0125
export var max_speed_friction: Vector2 = Vector2(1000.0, 1000.0)


func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	if event.is_action_released("slide"):
		_state_machine.transition_to("Move", { velocity = move.velocity })
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	owner.skin.play("run_naked")
	owner.enemy_detector.is_active = true
	move.friction = slide_friction
	move.max_speed = max_speed_friction
#### Old code to take as reference ####
#	if "velocity" in msg:
#		move.velocity = msg.velocity 
#		move.max_speed.x = max(abs(msg.velocity.x), move.max_speed.x)
#	if "impulse" in msg:
#		move.velocity += calculate_jump_velocity(msg.impulse)


func exit() -> void:
	var move: = get_parent()
	owner.enemy_detector.is_active = false
	move.friction = move.friction_default
	move.max_speed = move.max_speed_default
	move.exit()
