extends StaticBody2D
class_name Collectable

var player_ref: Object = null

export(String) var quest_key

export(int) var value
export(int) var target_value

export(bool) var can_interact

func _ready() -> void:
	DataManagement.load_data()
	if DataManagement.data_dictionary[quest_key]:
		queue_free()
		
		
func _process(_delta: float) -> void:
	if player_ref != null and Input.is_action_just_pressed("Interact") and can_interact:
		ScreenManagement.quest_container.update_quest(quest_key, value, target_value)
		queue_free()
		
		
func on_body_entered(body: CharacterTemplate) -> void:
	player_ref = body
	
	
func on_body_exited(_body: CharacterTemplate) -> void:
	player_ref = null
	
	
func enable_quest(key: String) -> void:
	if key == quest_key:
		can_interact = true
