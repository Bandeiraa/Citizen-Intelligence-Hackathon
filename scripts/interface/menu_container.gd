extends Control

signal create_character

onready var buttons_container: VBoxContainer = get_node("ButtonsContainer")
onready var load_button: Button = buttons_container.get_node("Load")

func _ready() -> void:
	connect_signals()
	
	
func connect_signals() -> void:
	for button in buttons_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
		
		
func on_button_pressed(button: Button) -> void:
	match button.name:
		"Play":
			emit_signal("create_character")
			
		"Load":
			send_data()
			
		"Exit":
			get_tree().quit()
			
			
func send_data() -> void:
	ScreenManagement.fade_in()
	yield(get_tree().create_timer(0.7), "timeout")
	var _change_scene = get_tree().change_scene("res://scenes/levels/character_room.tscn")
	
	
func show_load_button() -> void:
	load_button.show()
