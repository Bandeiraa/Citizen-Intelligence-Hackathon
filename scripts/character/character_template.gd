extends KinematicBody2D
class_name CharacterTemplate

onready var char_sprites: Node2D = get_node("CharacterSprites")

func _ready() -> void:
	for sprite in char_sprites.get_children():
		#sprite.texture =
		pass
