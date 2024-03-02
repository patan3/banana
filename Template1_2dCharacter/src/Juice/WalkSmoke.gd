extends CPUParticles2D

onready var previousPosition : Vector2 = global_position

func _physics_process(delta):
	var vel = (global_position - previousPosition).length()
	print(vel)
	if vel < 5.0:
		set_emitting(false)
		var a = emitting
		print(a)
	else:
		set_emitting(true)

	previousPosition = global_position
