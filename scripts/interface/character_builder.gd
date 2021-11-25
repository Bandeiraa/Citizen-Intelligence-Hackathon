extends Control

onready var animation_preview: AnimationPlayer = get_node("CharacterPreview/Animation")
onready var animation_parts: AnimationPlayer = get_node("CharacterPart/Animation")

onready var animation_list: Array = animation_preview.get_animation_list()

var anim_index: int = 0

func _ready() -> void:
	var _animation = animation_preview.connect("animation_finished", self, "on_animation_finished")
	
	
func on_animation_finished(_anim_name: String) -> void:
	animation_preview.play(animation_list[anim_index])
	animation_parts.play(animation_list[anim_index])
	anim_index = (anim_index + 1) % animation_list.size()
