extends CharacterTemplate

const DIALOG = preload("res://scenes/interface/dialog.tscn")

export(String) var npc_name

export(bool) var can_interact = true

onready var dialog_list: Array = [
	["Olá, este é o hospital, converse com os profissionais.", npc_name, ""], 
	["Conforme você for realizando as atividades, o mural a frente irá exibir informações sobre a Covid-19.", npc_name, ""], 
	["Boa sorte!", npc_name, ""]
]


func spawn_dialog() -> void:
	can_interact = false
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = dialog_list
	ScreenManagement.add_child(dialog)
	
	
func on_dialog_finished() -> void:
	get_tree().call_group("Character", "can_move")
	can_interact = true
