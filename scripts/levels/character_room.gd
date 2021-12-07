extends Node2D

onready var spawn_pos: Position2D = get_node("Spawn")
onready var tween: Tween = get_node("Tween")
onready var level_camera: Camera2D = get_node("LevelCamera")

const DIALOG = preload("res://scenes/interface/dialog.tscn")
const PLAYER = preload("res://scenes/character/main_character.tscn")

var player_name: String 
var room_dialog: Array = [
	["Instruções do Jogo: Pressione Enter ao final de uma mensagem para ir a mensagem seguinte.", "", ""], 
	["Pressione e segure Enter para acelerar a velocidade na qual a mensagem aparece.", "", ""], 
	["A ou Seta Esquerda -> Andar para a Esquerda.", "", ""],
	["D ou Seta Direita -> Andar para a Direita.", "", ""],
	["W ou Seta Cima -> Andar para Cima.", "", ""],
	["S ou Seta Baixo -> Andar para Baixo.", "", ""],
	["E -> Interagir.", "", ""],
	["Bom jogo, espero que goste!", "", ""]
]

func _ready() -> void:
	var _signal = ScreenManagement.connect("start_level", self, "start_level")
	
	
func start_level() -> void:
	verify_saved_data()
	
	
func verify_saved_data() -> void:
	DataManagement.load_data()
	if DataManagement.data_dictionary.PortalRoom:
		interpolate(Vector2(192, 212))
	elif DataManagement.data_dictionary.Tutorial:
		interpolate(Vector2(52, 52))
	else:
		instance_dialog()
		
		
func instance_player() -> void:
	var character: CharacterTemplate = PLAYER.instance()
	player_name = character.character_name
	character.global_position = spawn_pos.global_position
	$YSort.add_child(character)
	DataManagement.data_dictionary.Tutorial = true
	DataManagement.save_data()
	
	
func instance_dialog() -> void:
	var dialog: Dialog = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "interpolate", [Vector2(52, 52)])
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
	instance_player()
	
	
func on_level_changed():
	DataManagement.data_dictionary.PortalRoom = true
	DataManagement.save_data()
