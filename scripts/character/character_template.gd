extends KinematicBody2D

export(String) var character_texture

onready var char_sprite: Sprite = get_node("CharacterSprite")

func _ready() -> void:
	char_sprite.texture = character_texture
