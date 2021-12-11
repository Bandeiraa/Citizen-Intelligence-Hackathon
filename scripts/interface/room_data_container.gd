extends Control

signal close_data

onready var page_container: HBoxContainer = get_node("PageContainer")
onready var data_container: VBoxContainer = get_node("DataContainer")

var value_aux: float = 0

var data_list: Array
var text_template_list: Array = ["Valor Empenhado: R$ ", "Valor Pago: R$ "]

func _ready() -> void:
	serialize_data()
	connect_signals()
	show_data(value_aux)
	
	
func serialize_data() -> void:
	var file = File.new()
	file.open("res://assets/data/primeiro_trimestre_2020.txt", file.READ)
	while not file.eof_reached():
		var line = file.get_line()
		line = line.split(",")
		data_list.append(line)
		
	file.close()
	
	
func connect_signals() -> void:
	for children in page_container.get_children():
		if children is TextureButton:
			children.connect("pressed", self, "on_button_pressed", [children])
			
			
func show_data(aux_value: float) -> void:
	var index: float = aux_value
	for container in data_container.get_children():
		for node in container.get_children():
			var index_aux: int = 0
			if index < data_list.size():
				if not (node is Label):
					for label in node.get_children():
						label.text = text_template_list[index_aux] + data_list[index][index_aux + 1]
						index_aux += 1
				else:
					node.text = data_list[index][index_aux]
					
		index += 1
		
		
func on_button_pressed(button: TextureButton) -> void:
	if button.name == "LeftButton" and value_aux >= 4:
		value_aux -= 4
	elif button.name == "RightButton" and value_aux < data_list.size():
		value_aux += 4
		
	if value_aux == 0:
		page_container.get_node("LeftButton").disabled = true
	elif value_aux == data_list.size() - 4:
		page_container.get_node("RightButton").disabled = true
	else:
		page_container.get_node("LeftButton").disabled = false
		page_container.get_node("RightButton").disabled = false
		
	if value_aux == 0:
		page_container.get_node("PageNumber").text = "1"
	else:
		page_container.get_node("PageNumber").text = str((value_aux/4) + 1)
		
	show_data(value_aux)
	
	
func on_quit_button_pressed() -> void:
	get_tree().call_group("Character", "can_move")
	emit_signal("close_data")
	queue_free()
