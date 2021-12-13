extends Collectable

onready var animation: AnimationPlayer = get_node("Animation")
onready var timer: Timer = get_node("InteractCooldown")

func _ready() -> void:
	DataManagement.load_data()
	if DataManagement.data_dictionary[quest_key]:
		can_interact = false
		
		
func interact() -> void:
	if can_interact:
		animation.play("loop")
		can_interact = false
		timer.start(1.8)
		
		
func enable_quest(key: String) -> void:
	if key == quest_key:
		can_interact = true
		
		
func on_animation_finished(anim_name: String) -> void:
	if anim_name == "turn_off":
		ScreenManagement.quest_container.update_quest(quest_key, value, target_value)
		get_tree().call_group("Character", "can_move")
		animation.play("idle")
		
		
func on_interaction_timeout() -> void:
	animation.play("turn_off")
