extends Control

onready var character_builder: Control = get_node("CharacterBuilder")
onready var menu_container: Control = get_node("MenuContainer")

func _ready() -> void:
	verify_saved_data()
	
	
func verify_saved_data() -> void:
	var file: File = File.new()
	if file.file_exists(DataManagement.save_path):
		var _change_scn = get_tree().change_scene("res://scenes/levels/character_room.tscn")
	else:
		menu_container.show()
