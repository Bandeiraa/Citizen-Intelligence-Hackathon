extends InteractableObject

const ROOM_DATA = preload("res://scenes/interface/room_data_container.tscn")

func on_dialog_finished() -> void:
	var data: Object = ROOM_DATA.instance()
	var _close_data = data.connect("close_data", self, "on_data_close")
	ScreenManagement.add_child(data)
	
	
func on_data_close() -> void:
	can_interact = true
