extends StaticBody2D
class_name InteractableObject

export(bool) var can_interact

var player_ref: CharacterTemplate = null

func on_body_entered(body: CharacterTemplate) -> void:
	player_ref = body
	
	
func on_body_exited(_body: CharacterTemplate) -> void:
	player_ref = null
