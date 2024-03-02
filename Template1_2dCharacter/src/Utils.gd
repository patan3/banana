extends Node

func choose(array):
	randomize()
	return array[randi() % array.size()]
