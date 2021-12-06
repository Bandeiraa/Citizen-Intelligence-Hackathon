extends InteractableObject

const DIALOG = preload("res://scenes/interface/dialog.tscn")
const EMOTE_LIST = [
	preload("res://scenes/character/tear_effect.tscn"),
	preload("res://scenes/character/normal_effect.tscn"),
	preload("res://scenes/character/surprise_effect.tscn")
]

var phrase_list: Array = [
	"Não tive muita sorte, melhor tentar de novo!",
	"Legal!",
	"Estou com muita sorte hoje!"
]

var target_index: int 

func spawn_dialog() -> void:
	randomize()
	
	can_interact = false
	DataManagement.load_data()
	var player_name: String = DataManagement.data_dictionary.Name
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = [
		["Você joga os dados para saber como está a sua sorte hoje, e eles somam " + str(get_random_number()) + " ....", "", ""],
		[phrase_list[target_index], player_name, "Character", "spawn_emote", EMOTE_LIST[target_index]]
	]
	
	ScreenManagement.add_child(dialog)
	
	
func get_random_number() -> int:
	randomize()
	var random_number: int = randi() % 11 + 2
	if random_number <= 4:
		target_index = 0
	elif random_number > 4 and random_number <= 8:
		target_index = 1
	else:
		target_index = 2
		
	return random_number
	
	
func on_dialog_finished() -> void:
	get_tree().call_group("Character", "can_move")
	can_interact = true
