extends State
"""
Horizontal movement on the ground.
Delegates movement to its parent Move state and extends it
with state transitions
"""



func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	get_parent().enter(msg)


func exit() -> void:
	get_parent().exit()
