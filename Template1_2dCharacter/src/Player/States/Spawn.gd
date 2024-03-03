extends State
"""
Takes control away from the player and makes the character spawn
"""


var _start_position: = Vector3.ZERO


func _ready() -> void:
	yield(owner, "ready")
	_start_position = owner.transform.origin




func enter(_msg: Dictionary = {}) -> void:
	owner.is_active = false
	owner.position = _start_position
	owner.skin.play("spawn")
	owner.skin.connect("animation_finished", self, "_on_Player_animation_finished", [], CONNECT_DEFERRED)


func exit() -> void:
	owner.is_active = true
	owner.skin.disconnect("animation_finished", self, "_on_Player_animation_finished")



func _on_Player_animation_finished(_anim_name: String) -> void:
	_state_machine.transition_to('Move/Idle')
