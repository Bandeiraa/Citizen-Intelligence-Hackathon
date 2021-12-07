extends Area2D

signal change_level

export(String) var target_level

func on_body_entered(body: CharacterTemplate) -> void:
	emit_signal("change_level")
	body.can_move()
	ScreenManagement.fade_in(target_level)
