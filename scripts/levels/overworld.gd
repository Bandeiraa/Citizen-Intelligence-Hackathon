extends Control

func _process(delta):
	if Input.is_action_just_pressed("Down"):
		ScreenManagement.fade_in("res://scenes/levels/character_room.tscn")
