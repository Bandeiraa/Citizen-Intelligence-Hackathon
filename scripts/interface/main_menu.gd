extends Control

onready var character_builder: Control = get_node("CharacterBuilder")
onready var menu_container: Control = get_node("MenuContainer")

func _ready() -> void:
	verify_saved_data()
	
	
func verify_saved_data() -> void:
	var file: File = File.new()
	if file.file_exists(DataManagement.save_path):
		menu_container.show_load_button()
		
		
func show_character_builder() -> void:
	menu_container.hide()
	character_builder.show()
