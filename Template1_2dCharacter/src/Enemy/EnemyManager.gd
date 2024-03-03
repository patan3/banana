extends Spatial

onready var spawnPathRight : PathFollow = get_node("Path/PathFollow")
onready var spawnPathLeft : PathFollow = get_node("Path2/PathFollow")

onready var waves : Array = find_waves()
var betweenWaves = false
var waveIndex : int = 0

var enemy = preload("res://Template1_2dCharacter/src/Enemy/Enemy.tscn")

onready var timer = get_node("SpawnTimer")
onready var timerWave = get_node("WaveTimer")

enum SIDE {TOP, RIGHT, LEFT, BOTTOM}
	
func _ready():
	timer.connect("timeout", self, "spawn")
	timerWave.connect("timeout", self, "wave_end")
	if waves.empty():
		return
	timer.wait_time = waves[waveIndex].spawnInterval
	timerWave.wait_time = waves[waveIndex].waveDuration

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
