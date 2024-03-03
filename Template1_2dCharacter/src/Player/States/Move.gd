extends State
"""
Parent state that abstracts and handles basic movement
Move-related children states can delegate movement to it, or use its utility functions
"""
# A factor that controls the character's inertia.

onready var cooldown_timer: Timer = get_node("Slide/CooldownTimer")
onready var momentum_timer: Timer = get_node("Slide/MomentumTimer")

export var acceleration_default: = .5
export var friction_default: = .5
export var momentum_friction_default: = 1.0
export var max_speed_default: = Vector3(50.0, 0.0, 50.0)
export var bump_factor_default: float = 5.0

onready var max_speed: = max_speed_default
onready var acceleration: = acceleration_default
onready var velocity: = Vector3.ZERO
onready var friction = friction_default
onready var momentum_friction = momentum_friction_default
onready var bump_factor = bump_factor_default

var can_move: bool = true

func _ready():
	owner.get_node("EnemyDetector").connect("enemy_collected", self, "_on_EnemyDetector_enemy_collected")
	owner.connect("bounce", self, "_on_Player_bounce")
	momentum_timer.connect("timeout", self, "_on_MomentumTimer_timeout")
	cooldown_timer.connect("timeout", self, "_on_CooldownTimer_timeout")


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("slide") and cooldown_timer.is_stopped() and _state_machine._state_name!="Slide":
		_state_machine.transition_to("Move/Slide")
		print("Going to slide state")
	elif !cooldown_timer.is_stopped():
		owner.skin.sprite.set_modulate(Color(0.0, 0.5, 0.0, 1.0))
#	if owner.is_on_floor() and event.is_action_pressed("jump"):
#		_state_machine.transition_to("Move/Air", { impulse = jump_impulse })
#	if event.is_action_pressed('toggle_debug_move'):
#		_state_machine.transition_to('Debug')


func physics_process(_delta: float) -> void:
	# Once again, we call `Input.get_action_strength()` to support analog movement.
	var direction := Vector3(
		# This first line calculates the X direction, the vector's first component.
		Input.get_action_strength("left") - Input.get_action_strength("right"),
		# And here, we calculate the Y direction. Note that the Y-axis points 
		# DOWN in games.
		# That is to say, a Y value of `1.0` points downward.
		0.0,
		Input.get_action_strength("up") - Input.get_action_strength("down")
	)
	# When aiming the joystick diagonally, the direction vector can have a length 
	# greater than 1.0, making the character move faster than our maximum expected
	# speed. When that happens, we limit the vector's length to ensure the player 
	# can't go beyond the maximum speed.
#	if direction.length() > 1.0:
#		direction = direction.normalized()
#	# Using the follow steering behavior.
#	var target_velocity = direction * max_speed
##	print("Target velocity:   " + str(target_velocity) + " - " + "velocity:   "+str(velocity) + " * " + str(friction))
#	velocity += (target_velocity - velocity) * (1-friction) * _delta
##	print("Resulting velocity: " + str(velocity))
#	velocity.x = clamp(velocity.x, -max_speed.x, max_speed.x)
#	velocity.y = clamp(velocity.y, -max_speed.y, max_speed.y)
	if can_move:
		direction = get_input()
	else:
		direction = Vector3.ZERO
	if direction.length() > 0:
		velocity = velocity.linear_interpolate(direction.normalized() * max_speed, _delta * acceleration)
#		velocity = velocity.lerp(direction.normalized() * max_speed, acceleration)
	else:
		velocity = velocity.linear_interpolate(Vector3.ZERO, _delta*friction)
#		velocity = velocity.lerp(Vector2.ZERO, friction)
	velocity.x = clamp(velocity.x, -max_speed.x, max_speed.x)
	velocity.z = clamp(velocity.z, -max_speed.z, max_speed.z)
	velocity = owner.move_and_slide(velocity)


func enter(msg: Dictionary = {}) -> void:
#	$Air.connect("jumped", $Idle.jump_delay, "start")
	owner.skin.play("run")
	if "velocity" in msg:
		velocity = msg.velocity 


func exit() -> void:
	pass
#	$Air.disconnect("jumped", $Idle.jump_delay, "start")


func _on_EnemyDetector_enemy_collected():
	friction = momentum_friction
	momentum_timer.start()
	


func _on_MomentumTimer_timeout():
	friction = friction_default


func _on_CooldownTimer_timeout():
	owner.skin.sprite.set_modulate(Color(1.0, 1.0, 1.0, 1.0))


func _on_Player_bounce(bounce_direction: Vector3):
	if _state_machine._state_name == "Slide":
		velocity.x += bounce_direction.x * velocity.x * bump_factor
		velocity.z += bounce_direction.z * velocity.z * bump_factor

func get_input():
	var direction := Vector3(
		# This first line calculates the X direction, the vector's first component.
		Input.get_action_strength("left") - Input.get_action_strength("right"),
		# And here, we calculate the Y direction. Note that the Y-axis points 
		# DOWN in games.
		# That is to say, a Y value of `1.0` points downward.
		0.0,
		Input.get_action_strength("up") - Input.get_action_strength("down")
	)
	return direction


static func calculate_velocity(
		old_velocity: Vector3,
		max_speed: Vector3,
		acceleration: Vector3,
		delta: float,
		move_direction: Vector3
	) -> Vector3:
	var new_velocity: = old_velocity

	new_velocity += move_direction * acceleration * delta
	new_velocity.x = clamp(new_velocity.x, -max_speed.x, max_speed.x)
	new_velocity.z = clamp(new_velocity.z, -max_speed.z, max_speed.z)
	
	return new_velocity


static func get_move_direction() -> Vector3:
	return Vector3(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0.0,
		1.0
	)
