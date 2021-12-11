extends InteractableObject

var random_index: int
var phrase_list: Array = [
	"O dia hoje está ensolarado!", 
	"Hoje amanheceu com um clima chuvoso!", 
	"Algumas nuvens e o céu azul, o clima está agradável!"
]

func _ready() -> void:
	randomize()
	random_index = randi() % phrase_list.size()
	
	
func spawn_dialog() -> void:
	can_interact = false
	DataManagement.load_data()
	var player_name: String = DataManagement.data_dictionary.Name
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = [[phrase_list[random_index], player_name, ""]]
	ScreenManagement.add_child(dialog)
