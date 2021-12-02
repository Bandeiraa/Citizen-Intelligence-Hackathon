extends Node2D

onready var spawn_pos: Position2D = get_node("Spawn")

const PLAYER = preload("res://scenes/character/main_character.tscn")

func _ready() -> void:
	instance_player()
	
	
func instance_player() -> void:
	var player: CharacterTemplate = PLAYER.instance()
	player.global_position = spawn_pos.global_position
	get_tree().root.call_deferred("add_child", player)
