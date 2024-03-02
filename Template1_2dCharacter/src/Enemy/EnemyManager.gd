extends Node2D

export var startSpawnInterval = 1.0
export var difficultyIncreaseTimer = 5.0
export var difficultyIncreaseStep = 1.1
export var minSpawnInterval = 1.0

var enemy = preload("res://Template1_2dCharacter/src/Enemy/Enemy.tscn")

onready var timer = get_node("Timer")

var time_elapsed : float = 0.0

enum SIDE {TOP, RIGHT, LEFT, BOTTOM}

func _physics_process(delta):
	time_elapsed += delta
	if time_elapsed > difficultyIncreaseTimer && timer.wait_time > minSpawnInterval:
		timer.wait_time /= difficultyIncreaseStep
		time_elapsed = 0.0
	
func _ready():
	timer.wait_time = startSpawnInterval
	timer.connect("timeout", self, "spawn")

func generate_position():
	var size = get_viewport().size
	
	var side = Utils.choose([SIDE.LEFT, SIDE.RIGHT])
	
	match side:
		SIDE.TOP:
			return Vector2(rand_range(0.0, size.x), 0.0)
		SIDE.BOTTOM:
			return Vector2(rand_range(0.0, size.x), size.y)
		SIDE.LEFT:
			return Vector2(0.0, rand_range(0.0, size.y))
		SIDE.RIGHT:
			return Vector2(size.x, rand_range(0.0, size.y))

func spawn():
	var instance = enemy.instance()
	instance.position = generate_position()
	instance.direction = ceil(((get_viewport().size / 2) - instance.position).x)/(get_viewport().size.x/2)
	self.add_child(instance)

