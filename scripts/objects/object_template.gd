extends StaticBody2D
class_name InteractableObject

const DIALOG = preload("res://scenes/interface/dialog.tscn")

export(bool) var can_interact
export(bool) var can_change_sprite
export(bool) var can_call_player_name

export(String) var object_name
export(Array, String) var sprite_list
export(Array, Array, String) var dialog_list

func _ready() -> void:
	if can_change_sprite:
		randomize()
		var random_sprite: int = randi() % sprite_list.size()
		get_node("Texture").texture = load(sprite_list[random_sprite])
		
	if can_call_player_name:
		DataManagement.load_data()
		for list in dialog_list:
			list[1] = DataManagement.data_dictionary.Name
			
			
func spawn_dialog() -> void:
	can_interact = false
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = dialog_list
	ScreenManagement.add_child(dialog)
	
	
func on_dialog_finished() -> void:
	get_tree().call_group("Character", "can_move")
	can_interact = true
