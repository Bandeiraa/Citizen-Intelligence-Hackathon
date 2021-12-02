extends CanvasLayer

onready var animation: AnimationPlayer = get_node("Container/Animation")

func _ready() -> void:
	fade_out()
	
	
func fade_in() -> void:
	animation.play("fade_in")
	
	
func fade_out() -> void:
	animation.play("fade_out")


func on_animation_finished(anim_name) -> void:
	if anim_name == "fade_in":
		fade_out()
