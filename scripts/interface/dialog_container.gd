extends Control
class_name Dialog

signal dialog_finished

onready var dialog_text: RichTextLabel = get_node("DialogText")
onready var dialog_name: Label = get_node("Name")

export(float) var min_dialog_speed
export(float) var max_dialog_speed

var dialog_list: Array 

var dialog_index: int = 0

var key_released: bool = true

func _ready() -> void:
	update_dialog()
	
	
func _process(_delta: float) -> void:
	update_visible_text()
	if Input.is_action_just_released("Enter"):
		key_released = true
		
		
func update_visible_text() -> void:
	if dialog_text.percent_visible == 1 and Input.is_action_just_pressed("Enter"):
		update_dialog()
	elif Input.is_action_pressed("Enter") and key_released:
		dialog_text.percent_visible += max_dialog_speed
	else:
		dialog_text.percent_visible += min_dialog_speed
		
		
func update_dialog() -> void:
	if dialog_index == dialog_list.size():
		emit_signal("dialog_finished")
		queue_free()
		
	else:
		if dialog_index != 0:
			key_released = false
			
		dialog_text.text = dialog_list[dialog_index][0]
		dialog_name.text = dialog_list[dialog_index][1]
		dialog_text.percent_visible = 0
		dialog_index += 1
