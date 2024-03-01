extends State
"""
Parent state that abstracts and handles basic movement
Move-related children states can delegate movement to it, or use its utility functions
"""
# A factor that controls the character's inertia.
export var friction = 0.18

export var max_speed_default: = Vector2(500.0, 500.0)
export var acceleration_default: = Vector2(100000, 3000.0)
export var jump_impulse: = 900.0

var acceleration: = acceleration_default
var max_speed: = max_speed_default
var velocity: = Vector2.ZERO



func unhandled_input(event: InputEvent) -> void:
	pass
#	if owner.is_on_floor() and event.is_action_pressed("jump"):
#		_state_machine.transition_to("Move/Air", { impulse = jump_impulse })
#	if event.is_action_pressed('toggle_debug_move'):
#		_state_machine.transition_to('Debug')

func physics_process(_delta: float) -> void:
	# Once again, we call `Input.get_action_strength()` to support analog movement.
	var direction := Vector2(
		# This first line calculates the X direction, the vector's first component.
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		# And here, we calculate the Y direction. Note that the Y-axis points 
		# DOWN in games.
		# That is to say, a Y value of `1.0` points downward.
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# When aiming the joystick diagonally, the direction vector can have a length 
	# greater than 1.0, making the character move faster than our maximum expected
	# speed. When that happens, we limit the vector's length to ensure the player 
	# can't go beyond the maximum speed.
	if direction.length() > 1.0:
		direction = direction.normalized()
	# Using the follow steering behavior.
	var target_velocity = direction * max_speed
	velocity += (target_velocity - velocity) * friction
	velocity = owner.move_and_slide(velocity)

func enter(msg: Dictionary = {}) -> void:
#	$Air.connect("jumped", $Idle.jump_delay, "start")
	pass


func exit() -> void:
	pass
#	$Air.disconnect("jumped", $Idle.jump_delay, "start")


static func calculate_velocity(
		old_velocity: Vector2,
		max_speed: Vector2,
		acceleration: Vector2,
		delta: float,
		move_direction: Vector2
	) -> Vector2:
	var new_velocity: = old_velocity

	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.y = clamp(new_velocity.y, -max_speed.y, max_speed.y)

	return new_velocity


static func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		1.0
	)
