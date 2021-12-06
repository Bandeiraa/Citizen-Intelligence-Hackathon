extends StaticBody2D
class_name AnimatedObjectTemplate

onready var animation: AnimationPlayer = get_node("Animation")

export(bool) var can_interact
export(String) var object_name
