extends StaticBody2D
class_name AnimatedObjectTemplate

onready var animation: AnimationPlayer = get_node("Animation")
onready var timer: Timer = get_node("InteractCooldown")

export(float) var interact_cooldown
export(bool) var can_interact

export(String) var object_name
