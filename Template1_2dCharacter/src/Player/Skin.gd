extends Position3D
"""
The player's animated skin. Provides a simple interface to play animations.
"""


signal animation_finished(name)

onready var sprite: Sprite3D = get_node("pivot/banana")
onready var anim: AnimationPlayer = get_node("AnimationPlayer")


func _ready() -> void:
	anim.connect("animation_finished", self, "_on_Anim_animation_finished")


func _on_Anim_animation_finished(name: String) -> void:
	emit_signal("animation_finished", name)


func play(name: String, _data: Dictionary = {}) -> void:
	"""
	Plays the requested animation and safeguards against errors
	"""
	assert(name in anim.get_animation_list())
#	anim.stop()
	anim.play(name)


func play_sfx(path: String):
	if owner.state_machine._state_name == "Move":
		print(owner.state_machine._state_name == "Move")
		SfxManager.play_sfx(path)
