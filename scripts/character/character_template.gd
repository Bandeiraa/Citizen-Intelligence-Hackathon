extends KinematicBody2D
class_name CharacterTemplate

onready var char_sprites: Node2D = get_node("CharacterSprites")

var character_name: String

func _ready() -> void:
	DataManagement.load_data()
	character_name = DataManagement.data_dictionary.Name
	for sprite in char_sprites.get_children():
		sprite.texture = load(DataManagement.data_dictionary[sprite.name])
