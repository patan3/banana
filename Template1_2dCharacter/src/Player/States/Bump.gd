tool
extends State
"""
Manages Air movement, including jumping and landing.
You can pass a msg to this state, every key is optional:
{
	velocity: Vector2, to preserve inertia from the previous state
	impulse: float, to make the character jump
}
The player can jump after falling off a ledge. See unhandled_input and jump_delay.
"""

onready var cooldown_timer: Timer = get_node("CooldownTimer")

export var max_speed_bump: Vector2 = Vector2(1000.0, 1000.0)

func _ready():
	cooldown_timer.connect("timeout", self, "_on_CooldownTimer_timeout")

func unhandled_input(event: InputEvent) -> void:
	var move: = get_parent()
	move.unhandled_input(event)


func physics_process(delta: float) -> void:
	var move: = get_parent()
	move.physics_process(delta)



func enter(msg: Dictionary = {}) -> void:
	var move: = get_parent()
	move.enter(msg)
	move.max_speed = max_speed_bump
	move.can_move = false
	if "impulse" in msg:
		move.velocity += msg.impulse * 3
	cooldown_timer.start()




func exit() -> void:
	var move: = get_parent()
	move.can_move = true
	move.max_speed = move.max_speed_default
	move.exit()




func _on_CooldownTimer_timeout():
	_state_machine.transition_to("Move", { velocity = velocity})

