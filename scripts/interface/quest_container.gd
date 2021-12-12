extends Control

onready var quest_list: VBoxContainer = get_node("QuestList")
onready var header: Label = quest_list.get_node("Header")

var quest_dict: Dictionary = {}
var quest_index: int = 1

func _ready() -> void:
	verify_quest_list()
	
	
func verify_quest_list() -> void:
	for children in quest_list.get_children():
		if children is HBoxContainer and children.visible == true:
			header.visible = true
			return
			
	header.visible = false
	
	
func create_quest(quest_key: String, quest_description: String, amount: int, target_amount: int) -> void:
	quest_dict[quest_key] = [quest_index, amount]
	quest_list.get_child(quest_index).get_node("QuestDescription").text = quest_description
	quest_list.get_child(quest_index).get_node("Progress").text = str(amount) + "/" + str(target_amount)
	quest_list.get_child(quest_index).visible = true
	get_tree().call_group("Collectable", "enable_quest", quest_key)
	verify_quest_list()
	quest_index += 1
	
	
func update_quest(quest_key: String, amount: int, target_amount: int) -> void:
	var new_amount: int = amount + quest_dict[quest_key][1]
	quest_dict[quest_key] = [quest_dict[quest_key][0], new_amount]
	quest_list.get_child(quest_dict[quest_key][0]).get_node("Progress").text = str(new_amount) + "/" + str(target_amount)
	if new_amount == target_amount:
		get_tree().call_group("Npc", "can_end_quest", quest_key)
		
		
func delete_quest(quest_key: String) -> void:
	quest_list.get_child(quest_dict[quest_key][0]).get_node("QuestDescription").text = ""
	quest_list.get_child(quest_dict[quest_key][0]).get_node("Progress").text = ""
	quest_list.get_child(quest_dict[quest_key][0]).visible = false
	quest_dict[quest_key] = ""
	verify_quest_list()
	quest_index -= 1
