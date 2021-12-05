extends Control

onready var dialog_text: RichTextLabel = get_node("DialogText")

export(float) var dialog_speed

var dialog_index: int = 0
var dialog_test = ["Oiiiiiiiiiiiiiiiii", "Testeeeeeeeeeeee", "Siskinhooooooooo"]

func _ready() -> void:
	update_dialog(dialog_test)
	
	
func _process(_delta: float) -> void:
	dialog_text.percent_visible += dialog_speed
	if dialog_text.percent_visible == 1 and Input.is_action_just_pressed("Enter"):
		update_dialog(dialog_test)
		
		
func update_dialog(dialog_list: Array) -> void:
	if dialog_index == dialog_test.size():
		queue_free()
		
	else:
		dialog_text.text = dialog_list[dialog_index]
		dialog_text.percent_visible = 0
		dialog_index += 1
