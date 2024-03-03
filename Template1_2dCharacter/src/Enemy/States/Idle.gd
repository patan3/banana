extends State

enum MODULATOR {
	SIN,
	LINE,
	RANDOM
}

onready var pivot = get_node("../../Position3D")

var currentModulator

export var speedMinMax = Vector2(25.0, 50.0)
var speed = 25.0
var initial_direction : Vector3

var currentRandom = 0.0
var targetRandom = 0.0

func unhandled_input(_event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	var modulator = get_modulator(currentModulator, delta)
	var velocity = initial_direction + Vector3(0.0, 0.0, modulator)
	owner.move_and_slide( velocity * speed * delta)
	velocity = velocity.normalized()
	pivot.global_rotation.y = atan2(velocity.x, velocity.z) - (PI)


func enter(_msg: Dictionary = {}) -> void:
	initial_direction = Vector3(owner.direction, 0.0, 0.0).normalized()
	currentModulator = Utils.choose([MODULATOR.SIN, MODULATOR.LINE, MODULATOR.RANDOM])
	speed = rand_range(speedMinMax.x, speedMinMax.y)


func exit() -> void:
	return


func get_modulator(var modulator, var delta):
	match modulator: 
		MODULATOR.SIN:
			return sin(Time.get_unix_time_from_system())
		MODULATOR.LINE:
			return 0.0
		MODULATOR.RANDOM:
			if abs(currentRandom - targetRandom) < 0.05 :
				targetRandom = rand_range(-1.0, 1.0)
			currentRandom = lerp(currentRandom, targetRandom, 1.0 * delta)
			return currentRandom
