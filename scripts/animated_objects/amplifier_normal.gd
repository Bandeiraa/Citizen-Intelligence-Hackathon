extends AnimatedObjectTemplate

const DIALOG = preload("res://scenes/interface/dialog.tscn")

func spawn_dialog() -> void:
	can_interact = false
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = [["Você coloca uma música para tocar.", "", "Interface", "update_music", ""]]
	ScreenManagement.add_child(dialog)
	
	
func on_dialog_finished() -> void:
	get_tree().call_group("Character", "can_move")
	can_interact = true
