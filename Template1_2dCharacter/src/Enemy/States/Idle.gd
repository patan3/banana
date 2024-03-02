extends State

enum MODULATOR {
	SIN,
	LINE,
	RANDOM
}

var currentModulator

export var speed = 500.0
var initial_direction : Vector3

var currentRandom = 0.0
var targetRandom = 0.0

func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	var modulator = get_modulator(currentModulator, delta)
	var velocity = initial_direction + Vector3(0.0, 0.0, modulator)
	owner.move_and_slide( velocity * speed * delta)


func enter(msg: Dictionary = {}) -> void:
	initial_direction = Vector3(owner.direction, 0.0, 0.0).normalized()
	print(initial_direction)
	currentModulator = Utils.choose([MODULATOR.SIN, MODULATOR.LINE, MODULATOR.RANDOM])


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
