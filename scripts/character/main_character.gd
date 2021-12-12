extends CharacterTemplate

onready var raycast: RayCast2D = get_node("RayCast")

func _physics_process(_delta: float) -> void:
	if not interacting:
		move()
	else:
		velocity = Vector2.ZERO
		
	animate()
	verify_raycast()
	
	
func move() -> void:
	var input: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("Right") or Input.is_action_pressed("Left"):
		input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	elif Input.is_action_pressed("Down") or Input.get_action_strength("Up"):
		input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
		
	input = input.normalized()
	
	if input != Vector2.ZERO:
		raycast.cast_to = input * 15
		animation_tree.set("parameters/idle/blend_position", input)
		animation_tree.set("parameters/walk/blend_position", input)
		
	velocity = input * walk_speed
	velocity = move_and_slide(velocity)
	
	
func verify_raycast() -> void:
	if raycast.get_collider() != null:
		if raycast.get_collider().owner.can_interact and Input.is_action_just_pressed("Interact"):
			raycast.get_collider().owner.spawn_dialog()
			can_move()
			
			
func can_move() -> void:
	interacting = !interacting
