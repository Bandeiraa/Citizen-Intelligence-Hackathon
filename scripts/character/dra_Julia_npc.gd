extends CharacterTemplate

const DIALOG = preload("res://scenes/interface/dialog.tscn")

export(String) var npc_name
export(String) var npc_quest
export(String) var quest_description

export(bool) var can_interact = true

export(int) var target_amount

var dialog_index: int = 0

onready var dialog_list: Array = [
	[
		["Olá, antes de acessar os dados você precisa ter em mente que muitas pessoas usam eles...", npc_name, ""], 
		["Antes de permitir acessá-los, preciso que você lave bem as mãos no banheiro...", npc_name, ""], 
		["Para não contaminar nada, estarei no aguardo!", npc_name, ""]
	],
	[
		["Meus parabéns ao completar esta atividade!", npc_name, ""],
		["Agora você poderá acessar as informações do quadro acima, obrigado!", npc_name, ""]
	]
]

func _ready() -> void:
	DataManagement.load_data()
	if DataManagement.data_dictionary[npc_quest]:
		can_interact = false
		
		
func spawn_dialog() -> void:
	can_interact = false
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = dialog_list[dialog_index]
	ScreenManagement.add_child(dialog)
	
	
func on_dialog_finished() -> void:
	if dialog_index == dialog_list.size() - 1:
		ScreenManagement.quest_container.delete_quest(npc_quest)
		get_tree().call_group("Panel", "enable_panel", npc_quest)
	else:
		ScreenManagement.quest_container.create_quest(npc_quest, quest_description, 0, target_amount)
		
	get_tree().call_group("Character", "can_move")
	
	
func can_end_quest(quest_key: String) -> void:
	if quest_key == npc_quest:
		dialog_index += 1
		can_interact = true
