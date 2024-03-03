extends Node2D

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


func wave_end():
	
	if !betweenWaves:
		betweenWaves = true
		timerWave.start(3.0)
		timer.stop()
	else:
		waveIndex += 1
		print("waves: " + str(waveIndex + 1))
		if waveIndex >= waves.size():
			printerr("NO MORE WAVES")
			return
		betweenWaves = false
		timer.start(waves[waveIndex].spawnInterval)
		timerWave.start(waves[waveIndex].waveDuration)


func spawn():
	var instance = enemy.instance()
	instance.position = generate_position()
	instance.direction = ceil(((get_viewport().size / 2) - instance.position).x)/(get_viewport().size.x/2)
	self.add_child(instance)

func find_waves():
	var all_waves = []
	for child in get_children():
		if child is Wave:
			all_waves.append(child)
	return all_waves
