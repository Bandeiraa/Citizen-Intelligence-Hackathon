extends CanvasLayer

onready var animation: AnimationPlayer = get_node("Container/Animation")

signal start_level

func _ready() -> void:
	fade_out()
	
	
func fade_in() -> void:
	animation.play("fade_in")
	
	
func fade_out() -> void:
	animation.play("fade_out")
	
	
func update_music(_song: String) -> void:
	pass
	
	
func on_animation_finished(anim_name) -> void:
	match anim_name:
		"fade_in":
			fade_out()
		
		"fade_out":
			emit_signal("start_level")
			
