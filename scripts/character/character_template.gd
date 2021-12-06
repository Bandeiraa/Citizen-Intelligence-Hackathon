extends KinematicBody2D
class_name CharacterTemplate

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var blend_tree = animation_tree.get("parameters/playback")
onready var char_sprites: Node2D = get_node("CharacterSprites")
onready var raycast: RayCast2D = get_node("RayCast")

var character_name: String
var velocity: Vector2

var interacting: bool = false

export(int) var walk_speed: int

func _ready() -> void:
	animation_tree.set_active(true)
	DataManagement.load_data()
	character_name = DataManagement.data_dictionary.Name
	for sprite in char_sprites.get_children():
		sprite.texture = load(DataManagement.data_dictionary[sprite.name])
		
		
func _physics_process(_delta: float) -> void:
	move()
	animate()
	if raycast.get_collider() != null:
		if raycast.get_collider().owner.can_interact and Input.is_action_just_pressed("Interact"):
			raycast.get_collider().owner.spawn_dialog()
			
			
func move() -> void:
	var input: Vector2 = Vector2.ZERO
	input.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	input.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	input = input.normalized()
	
	if input != Vector2.ZERO:
		raycast.cast_to = input * 15
		animation_tree.set("parameters/idle/blend_position", input)
		animation_tree.set("parameters/walk/blend_position", input)
	
	velocity = input * walk_speed
	velocity = move_and_slide(velocity)
	
	
func animate() -> void:
	if velocity != Vector2.ZERO:
		blend_tree.travel("walk")
	else:
		blend_tree.travel("idle")
