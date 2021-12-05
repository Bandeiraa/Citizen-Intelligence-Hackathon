extends Node2D

onready var spawn_pos: Position2D = get_node("Spawn")
onready var tween: Tween = get_node("Tween")
onready var level_camera: Camera2D = get_node("LevelCamera")

const DIALOG = preload("res://scenes/interface/dialog.tscn")
const PLAYER = preload("res://scenes/character/main_character.tscn")

var room_dialog: Array

func _ready() -> void:
	var _signal = ScreenManagement.connect("start_level", self, "start_level")
	
	
func start_level() -> void:
	verify_saved_data()
	
	
func verify_saved_data() -> void:
	DataManagement.load_data()
	var player_name: String = DataManagement.data_dictionary.Name
	if DataManagement.data_dictionary.Tutorial:
		interpolate()
	else:
		room_dialog = [
			["..........................", player_name], 
			["..........................", player_name], 
			["..........................", player_name], 
			["Teste.", player_name]
		]
		
		instance_dialog()
		
		
func instance_player() -> void:
	var player: CharacterTemplate = PLAYER.instance()
	player.global_position = spawn_pos.global_position
	get_tree().root.call_deferred("add_child", player)
	DataManagement.data_dictionary.Tutorial = true
	DataManagement.save_data()
	
	
func instance_dialog() -> void:
	var dialog: Dialog = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "interpolate")
	dialog.dialog_list = room_dialog
	ScreenManagement.add_child(dialog)
	
	
func interpolate() -> void:
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
	instance_player()
