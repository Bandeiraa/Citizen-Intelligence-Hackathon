extends InteractableObject

const ROOM_DATA = preload("res://scenes/interface/room_data_container.tscn")

export(String) var data_to_serialize
export(String) var target_quest_panel

func _ready() -> void:
	DataManagement.load_data()
	if can_interact == false:
		if DataManagement.data_dictionary[target_quest_panel]:
			can_interact = true
			
			
func on_dialog_finished() -> void:
	var data: Object = ROOM_DATA.instance()
	var _close_data = data.connect("close_data", self, "on_data_close")
	data.data_to_serialize = data_to_serialize
	ScreenManagement.add_child(data)
	
	
func on_data_close() -> void:
	can_interact = true
	
	
func enable_panel(quest: String) -> void:
	if quest == target_quest_panel:
		DataManagement.data_dictionary[target_quest_panel] = true
		DataManagement.save_data()
		can_interact = true
