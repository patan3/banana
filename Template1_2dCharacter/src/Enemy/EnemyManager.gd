extends Spatial

onready var spawnPathRight : Area = get_node("SpawnArea_R")
onready var spawnPathLeft : Area = get_node("SpawnArea_L")

onready var waves : Array = find_waves()
var betweenWaves = false
var waveIndex : int = 0

var enemy = preload("res://Template1_2dCharacter/src/Enemy/Enemy.tscn")

onready var timer = get_node("SpawnTimer")
onready var timerWave = get_node("WaveTimer")

enum SIDE {TOP, RIGHT, LEFT, BOTTOM}
	
func _ready():
	spawnPathLeft.connect("body_entered", self, "enemy_entered_left_path")
	spawnPathRight.connect("body_entered", self, "enemy_entered_right_path")
	
	timer.connect("timeout", self, "spawn")
	timerWave.connect("timeout", self, "wave_end")
	if waves.empty():
		return
	timer.wait_time = waves[waveIndex].spawnInterval
	timerWave.wait_time = waves[waveIndex].waveDuration


func enemy_entered_left_path(body : Node):
	if body.is_in_group("enemies"):
		if body.direction == 1:
			print("lose_point")
	
func enemy_entered_right_path(body : Node):
	if body.is_in_group("enemies"):
		if body.direction == -1:
			print("lose_point")

func generate_position() -> Vector3:
	var side = Utils.choose([SIDE.LEFT, SIDE.RIGHT])
	
	match side:
		SIDE.LEFT:
			var shape : BoxShape = spawnPathLeft.get_child(0).shape
			var randomZ = rand_range(
				spawnPathLeft.global_transform.origin.z - shape.extents.z,
				spawnPathLeft.global_transform.origin.z + shape.extents.z)
			var pos = Vector3(
				spawnPathLeft.global_transform.origin.x,
				spawnPathLeft.global_transform.origin.y,
				randomZ)
			return pos
		SIDE.RIGHT:
			var shape : BoxShape = spawnPathLeft.get_child(0).shape
			var randomZ = rand_range(
				spawnPathRight.global_transform.origin.z - shape.extents.z,
				spawnPathRight.global_transform.origin.z + shape.extents.z)
			var pos = Vector3(
				spawnPathRight.global_transform.origin.x,
				spawnPathRight.global_transform.origin.y,
				randomZ)
			return pos
		_:
			return Vector3.ZERO


func wave_end():
	
	if !betweenWaves:
		betweenWaves = true
		timerWave.start(waves[waveIndex].waveRecuperation)
		timer.stop()
	else:
		if waveIndex >= waves.size() - 1:
			printerr("NO MORE WAVES")
			timer.start(waves[waveIndex].spawnInterval)
			timerWave.stop()
			return
		waveIndex += 1
		print("waves: " + str(waveIndex + 1))
		betweenWaves = false
		timer.start(waves[waveIndex].spawnInterval)
		timerWave.start(waves[waveIndex].waveDuration)


func spawn():
	var instance = enemy.instance()
	instance.transform.origin = generate_position()
	if instance.transform.origin.x > 0.0:
		instance.direction = -1.0
	else:
		instance.direction = 1.0
	
	self.add_child(instance)

func find_waves():
	var all_waves = []
	for child in get_children():
		if child is Wave:
			all_waves.append(child)
	return all_waves
