extends State

export var speed = 500.0
var initial_direction : Vector2

func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	var modulator = sin(Time.get_unix_time_from_system())
	var velocity = initial_direction + Vector2(0.0, modulator)
	owner.move_and_slide( velocity * speed * delta)


func enter(msg: Dictionary = {}) -> void:
	initial_direction = Vector2(choose([-1, 1]), 0.0).normalized()


func exit() -> void:
	return

func choose(array):
	randomize()
	return array[randi() % array.size()]
