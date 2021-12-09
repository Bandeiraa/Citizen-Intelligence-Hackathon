extends Control

onready var tween: Tween = get_node("Tween")
onready var buttons_container: Control = get_node("ButtonsContainer")
onready var location: Label = get_node("LabelContainer/CurrentLocation")

var can_interact: bool = true

func _ready() -> void:
	for button in buttons_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "on_mouse_exited", [button])
		button.connect("mouse_entered", self, "on_mouse_entered", [button])
		
		
func on_button_pressed(button: TextureButton) -> void:
	if can_interact:
		can_interact = false
		var _start_tween = tween.interpolate_property(
			button, 
			"modulate:a", 
			button.modulate.a, 
			0,
			0.2,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT
		)
		
		var _end_tween = tween.interpolate_property(
			button,
			"modulate:a",
			0,
			1,
			0.2,
			Tween.TRANS_QUAD,
			Tween.EASE_OUT,
			0.2
		)
		
		var _start = tween.start()
		
		
func on_mouse_entered(button: TextureButton) -> void:
	if button.disabled and can_interact:
		location.text = "Em breve!"
	elif not button.disabled and can_interact:
		location.text = button.name
		
		
func on_mouse_exited(_button: TextureButton) -> void:
	if can_interact:
		location.text = ""
		
		
func on_tween_completed(object: TextureButton, _key: NodePath) -> void:
	match object.name:
		"Parque":
			#change_level()
			pass
			
		"Escola":
			#change_level()
			pass
			
		"Casa":
			change_level("res://scenes/levels/character_room.tscn")
			
			
func change_level(target_level: String) -> void:
	ScreenManagement.fade_in(target_level)
	
