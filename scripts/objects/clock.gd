extends InteractableObject

const DIALOG = preload("res://scenes/interface/dialog.tscn")

var os_data = OS.get_datetime()

var month_list: Array = [
	"Janeiro", 
	"Fevereiro", 
	"Março", 
	"Abril", 
	"Maio",
	"Junho", 
	"Julho", 
	"Agosto", 
	"Setembro", 
	"Outubro",
	"Novembro", 
	"Dezembro"
]

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact") and player_ref != null and can_interact:
		spawn_dialog()
		
		
func get_datetime() -> String:
	os_data = OS.get_datetime()
	var month: String 
	var day: String = str(os_data.day)
	var hour: String = str(os_data.hour)
	var minute: String = str(os_data.minute)
	
	if os_data.day < 10:
		day = "0" + str(os_data.day)
		
	if os_data.hour < 10:
		hour = "0" + str(os_data.hour)
		
	if os_data.minute < 10:
		minute = "0" + str(os_data.minute)
		
	month = month_list[os_data.month - 1]
	return "O Relógio está indicando que são " + hour + ":" + minute + ", do dia " + day + " de " + month + "."
	
	
func on_body_entered(body: CharacterTemplate) -> void:
	player_ref = body
	
	
func on_body_exited(_body: CharacterTemplate) -> void:
	player_ref = null
	
	
func spawn_dialog() -> void:
	can_interact = false
	DataManagement.load_data()
	var player_name: String = DataManagement.data_dictionary.Name
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = [[get_datetime(), player_name]]
	ScreenManagement.add_child(dialog)
	
	
func on_dialog_finished() -> void:
	can_interact = true
