extends KinematicBody2D
class_name CharacterTemplate

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var blend_tree = animation_tree.get("parameters/playback")
onready var char_sprites: Node2D = get_node("CharacterSprites")
onready var emote_spawner: Position2D = get_node("EmoteSpawn")
onready var tween: Tween = get_node("Tween")

var character_name: String
var velocity: Vector2

var interacting: bool = false

export(bool) var can_change_sprite = true

export(int) var walk_speed: int

export(Vector2) var travel = Vector2(0, -80)
export(float) var spread = PI/4
export(float) var duration = 1.5

func _ready() -> void:
	animation_tree.set_active(true)
	if can_change_sprite:
		DataManagement.load_data()
		character_name = DataManagement.data_dictionary.Name
		for sprite in char_sprites.get_children():
			sprite.texture = load(DataManagement.data_dictionary[sprite.name])
			
			
func _physics_process(_delta: float) -> void:
	if not interacting:
		move()
	else:
		velocity = Vector2.ZERO
		
	animate()
			
			
func move() -> void:
	pass
	
	
func animate() -> void:
	if velocity != Vector2.ZERO:
		blend_tree.travel("walk")
	else:
		blend_tree.travel("idle")
		
		
func spawn_emote(emote: Object) -> void:
	var current_emote: Object = emote.instance()
	emote_spawner.add_child(current_emote)
	var _signal = current_emote.connect("animation_finished", self, "start_interpolation", [current_emote])
	
	
func start_interpolation(emote: Object) -> void:
	randomize()
	var movement: Vector2 = travel.rotated(rand_range(-spread/2, spread/2))
	var _interpolate_pos = tween.interpolate_property(
		emote, 
		"global_position", 
		emote_spawner.global_position, 
		emote_spawner.global_position + movement,
		duration,
		Tween.TRANS_QUAD, 
		Tween.EASE_OUT
	)
	
	var _intepolate_color = tween.interpolate_property(
		emote, 
		"modulate:a", 
		1.0, 
		0.0,
		duration,
		Tween.TRANS_QUAD, 
		Tween.EASE_OUT
	)
	
	var _start = tween.start()
	
	
func on_tween_finished(object, _key) -> void:
	object.queue_free()


func on_timer_timeout() -> void:
	pass
