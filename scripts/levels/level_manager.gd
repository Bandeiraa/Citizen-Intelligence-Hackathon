extends Node2D
class_name LevelManager

export(Vector2) var initial_spawn_position

onready var spawn_pos: Position2D = get_node("Spawn")
onready var tween: Tween = get_node("Tween")
onready var level_camera: Camera2D = get_node("LevelCamera")

const DIALOG = preload("res://scenes/interface/dialog.tscn")
const PLAYER = preload("res://scenes/character/main_character.tscn")

var player_name: String 
var room_dialog: Array

func _ready() -> void:
	var _signal = ScreenManagement.connect("start_level", self, "start_level")
	
	
func start_level() -> void:
	verify_saved_data()
	
	
func verify_saved_data() -> void:
	pass
		
		
func instance_player(level_tutorial: String) -> void:
	var character: CharacterTemplate = PLAYER.instance()
	player_name = character.character_name
	character.global_position = spawn_pos.global_position
	$YSort.add_child(character)
	DataManagement.data_dictionary[level_tutorial] = true
	DataManagement.save_data()
	
	
func instance_dialog() -> void:
	var dialog: Dialog = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "interpolate", [initial_spawn_position])
	dialog.dialog_list = room_dialog
	ScreenManagement.add_child(dialog)
	
	
func interpolate(spawn_position: Vector2) -> void:
	spawn_pos.global_position = spawn_position
	var _interpolate = tween.interpolate_property(
		level_camera, 
		"position", 
		level_camera.global_position, 
		spawn_pos.global_position, 
		1.5, 
		Tween.TRANS_QUAD, 
		Tween.EASE_IN_OUT
	)
	
	var _start_tween = tween.start()
	
	
func on_tween_completed() -> void:
	pass
