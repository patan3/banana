extends Spatial

onready var spawnPathRight : PathFollow = get_node("Path/PathFollow")
onready var spawnPathLeft : PathFollow = get_node("Path2/PathFollow")

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

func generate_position() -> Vector3:
	var path : PathFollow = Utils.choose([spawnPathRight, spawnPathLeft])
	
	var side = Utils.choose([SIDE.LEFT, SIDE.RIGHT])
	
	match side:
		SIDE.LEFT:
			path.unit_offset = randf()
			return path.global_transform.origin
		SIDE.RIGHT:
			return path.global_transform.origin
		_:
			return Vector3.ZERO

func spawn():
	var instance = enemy.instance()
	instance.transform.origin = generate_position()
	if instance.transform.origin.x > 0.0:
		instance.direction = -1.0
	else:
		instance.direction = 1.0
	
	self.add_child(instance)

