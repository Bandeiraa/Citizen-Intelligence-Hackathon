extends CharacterTemplate

const DIALOG = preload("res://scenes/interface/dialog.tscn")

export(String) var npc_name

export(bool) var can_interact = true

onready var dialog_list: Array = [
	["Olá, este é o hospital, converse com os profissionais.", npc_name, ""], 
	["Conforme você for realizando as atividades, o mural a frente irá exiir informações sobre a Covid-19.", npc_name, ""], 
	["Boa sorte!", npc_name, ""]
]

func move() -> void:
	var input: Vector2 = Vector2.ZERO
	#input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	#input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	#input = input.normalized()
	
	if input != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", input)
		animation_tree.set("parameters/walk/blend_position", input)
		
	velocity = input * walk_speed
	velocity = move_and_slide(velocity)
	
	
func spawn_dialog() -> void:
	can_interact = false
	var dialog: Object = DIALOG.instance()
	var _signal = dialog.connect("dialog_finished", self, "on_dialog_finished")
	dialog.dialog_list = dialog_list
	#[["Melhor eu não mexer para não quebrar nada!", player_name, ""]]
	ScreenManagement.add_child(dialog)
	
	
func on_dialog_finished() -> void:
	get_tree().call_group("Character", "can_move")
	can_interact = true
