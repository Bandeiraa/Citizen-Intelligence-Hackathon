extends Camera2D

onready var player: KinematicBody2D = get_node("..")

func _process(_delta: float) -> void:
	var target: Vector2 = player.global_position
	var target_x_pos: int = int(lerp(global_position.x, target.x, .2))
	var target_y_pos: int = int(lerp(global_position.y, target.y, .2))
	global_position = Vector2(target_x_pos, target_y_pos)
