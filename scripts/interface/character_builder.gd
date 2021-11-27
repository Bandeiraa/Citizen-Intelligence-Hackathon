extends Control

onready var buttons_container: Control = get_node("Background/ButtonsContainer")

onready var animation_preview: AnimationPlayer = get_node("Background/PreviewContainer/CharacterPreview/Animation")
onready var animation_parts: AnimationPlayer = get_node("Background/PartsContainer/CharacterPart/Animation")

onready var animation_list: Array = animation_preview.get_animation_list()

var current_eye: String
var current_body: String
var current_hair: String
var current_outfit: String

var animation: bool = true

var eye_index: int = 0
var body_index: int = 0
var hair_index: int = 0
var outfit_index: int = 0

var anim_index: int = 0

var checkbox_on: String = "res://assets/user_interface/button/checkbox_on.png"
var checkbox_off: String = "res://assets/user_interface/button/checkbox_off.png"

var body_list: Array = ["res://assets/character/body/body_01.png", "res://assets/character/body/body_02.png",
						"res://assets/character/body/body_03.png", "res://assets/character/body/body_04.png",
						"res://assets/character/body/body_05.png", "res://assets/character/body/body_06.png",
						"res://assets/character/body/body_07.png", "res://assets/character/body/body_08.png",
						"res://assets/character/body/body_09.png"]
						
var eye_list: Array = ["res://assets/character/eye/eyes_01.png", "res://assets/character/eye/eyes_02.png",
						"res://assets/character/eye/eyes_03.png", "res://assets/character/eye/eyes_04.png",
						"res://assets/character/eye/eyes_05.png", "res://assets/character/eye/eyes_06.png",
						"res://assets/character/eye/eyes_07.png"]
						
var hair_list: Array = ["res://assets/character/hairstyle/hairstyle_01.png", "res://assets/character/hairstyle/hairstyle_02.png",
						"res://assets/character/hairstyle/hairstyle_03.png", "res://assets/character/hairstyle/hairstyle_04.png",
						"res://assets/character/hairstyle/hairstyle_05.png", "res://assets/character/hairstyle/hairstyle_06.png",
						"res://assets/character/hairstyle/hairstyle_07.png", "res://assets/character/hairstyle/hairstyle_08.png",
						"res://assets/character/hairstyle/hairstyle_09.png", "res://assets/character/hairstyle/hairstyle_10.png",
						"res://assets/character/hairstyle/hairstyle_11.png", "res://assets/character/hairstyle/hairstyle_12.png",
						"res://assets/character/hairstyle/hairstyle_13.png", "res://assets/character/hairstyle/hairstyle_14.png",
						"res://assets/character/hairstyle/hairstyle_15.png", "res://assets/character/hairstyle/hairstyle_16.png",
						"res://assets/character/hairstyle/hairstyle_17.png", "res://assets/character/hairstyle/hairstyle_18.png",
						"res://assets/character/hairstyle/hairstyle_19.png", "res://assets/character/hairstyle/hairstyle_20.png",
						"res://assets/character/hairstyle/hairstyle_21.png", "res://assets/character/hairstyle/hairstyle_22.png",
						"res://assets/character/hairstyle/hairstyle_23.png", "res://assets/character/hairstyle/hairstyle_24.png",
						"res://assets/character/hairstyle/hairstyle_25.png", "res://assets/character/hairstyle/hairstyle_26.png",
						"res://assets/character/hairstyle/hairstyle_27.png", "res://assets/character/hairstyle/hairstyle_28.png",
						"res://assets/character/hairstyle/hairstyle_29.png"]
						
var outfit_list: Array = ["res://assets/character/outfit/outfit_01.png", "res://assets/character/outfit/outfit_02.png",
							"res://assets/character/outfit/outfit_03.png", "res://assets/character/outfit/outfit_04.png",
							"res://assets/character/outfit/outfit_05.png", "res://assets/character/outfit/outfit_06.png",
							"res://assets/character/outfit/outfit_07.png", "res://assets/character/outfit/outfit_08.png",
							"res://assets/character/outfit/outfit_09.png", "res://assets/character/outfit/outfit_10.png",
							"res://assets/character/outfit/outfit_11.png", "res://assets/character/outfit/outfit_12.png",
							"res://assets/character/outfit/outfit_13.png", "res://assets/character/outfit/outfit_14.png",
							"res://assets/character/outfit/outfit_15.png", "res://assets/character/outfit/outfit_16.png",
							"res://assets/character/outfit/outfit_17.png", "res://assets/character/outfit/outfit_18.png",
							"res://assets/character/outfit/outfit_19.png", "res://assets/character/outfit/outfit_20.png",
							"res://assets/character/outfit/outfit_21.png", "res://assets/character/outfit/outfit_22.png",
							"res://assets/character/outfit/outfit_23.png", "res://assets/character/outfit/outfit_24.png",
							"res://assets/character/outfit/outfit_25.png", "res://assets/character/outfit/outfit_26.png",
							"res://assets/character/outfit/outfit_27.png", "res://assets/character/outfit/outfit_28.png",
							"res://assets/character/outfit/outfit_29.png", "res://assets/character/outfit/outfit_30.png",
							"res://assets/character/outfit/outfit_31.png", "res://assets/character/outfit/outfit_32.png",
							"res://assets/character/outfit/outfit_33.png"]
							
func _ready() -> void:
	connect_signals()
	
	
func connect_signals() -> void:
	var _animation = animation_preview.connect("animation_finished", self, "on_animation_finished")
	for hbox in buttons_container.get_children():
		for children in hbox.get_children():
			if children is TextureButton:
				children.connect("pressed", self, "on_button_pressed", [children])
				
				
func on_animation_finished(_anim_name: String) -> void:
	animation_preview.play(animation_list[anim_index])
	animation_parts.play(animation_list[anim_index])
	anim_index = (anim_index + 1) % animation_list.size()
	
	
func on_button_pressed(button: TextureButton) -> void:
	match button.name:
		"BodyLeft":
			if body_index > 0:
				body_index -= 1
				change_sprite("Body", body_index, body_list)
				verify_button(body_index, button, buttons_container.get_node("BodyButtons/BodyRight"), body_list)
			
		"BodyRight":
			if body_index < (body_list.size() - 1):
				body_index += 1
				change_sprite("Body", body_index, body_list)
				verify_button(body_index, button, buttons_container.get_node("BodyButtons/BodyLeft"), body_list)
				
		"EyeLeft":
			if eye_index > 0:
				eye_index -= 1
				change_sprite("Eye", eye_index, eye_list)
				verify_button(eye_index, button, buttons_container.get_node("EyeButtons/EyeRight"), eye_list)
				
		"EyeRight":
			if eye_index < (eye_list.size() - 1):
				eye_index += 1
				change_sprite("Eye", eye_index, eye_list)
				verify_button(eye_index, button, buttons_container.get_node("EyeButtons/EyeLeft"), eye_list)
				
		"HairLeft":
			if hair_index > 0:
				hair_index -= 1
				change_sprite("Hair", hair_index, hair_list)
				verify_button(hair_index, button, buttons_container.get_node("HairButtons/HairRight"), hair_list)
				
		"HairRight":
			if hair_index < (hair_list.size() - 1):
				hair_index += 1
				change_sprite("Hair", hair_index, hair_list)
				verify_button(hair_index, button, buttons_container.get_node("HairButtons/HairLeft"), hair_list)
				
		"OutfitLeft":
			if outfit_index > 0:
				outfit_index -= 1
				change_sprite("Outfit", outfit_index, outfit_list)
				verify_button(outfit_index, button, buttons_container.get_node("OutfitButtons/OutfitRight"), outfit_list)
				
		"OutfitRight":
			if outfit_index < (outfit_list.size() - 1):
				outfit_index += 1
				change_sprite("Outfit", outfit_index, outfit_list)
				verify_button(outfit_index, button, buttons_container.get_node("OutfitButtons/OutfitLeft"), outfit_list)
				
		"Checkbox":
			animation = !animation
			if animation:
				buttons_container.get_node("CheckBoxButtons/Checkbox").texture_normal = load(checkbox_on)
				turn_animation(true)
			else:
				buttons_container.get_node("CheckBoxButtons/Checkbox").texture_normal = load(checkbox_off)
				turn_animation(false)
				
				
func change_sprite(target_piece: String, index: int, target_list: Array) -> void:
	var parts_container: Node2D = get_node("Background/PartsContainer/CharacterPart/CharacterSprites")
	var preview_container: Node2D = get_node("Background/PreviewContainer/CharacterPreview/CharacterSprites")
	parts_container.get_node(target_piece).texture = load(target_list[index])
	preview_container.get_node(target_piece).texture = load(target_list[index])
	
	
func verify_button(index: int, button: TextureButton, opposite_button: TextureButton, list: Array) -> void:
	if index == 0 or index == (list.size() - 1):
		button.disabled = true
	else:
		button.disabled = false
		opposite_button.disabled = false
		
		
func turn_animation(is_active: bool) -> void:
	if is_active:
		animation_preview.play(animation_list.min())
		animation_parts.play(animation_list.min())
		anim_index = 0
	else:
		animation_parts.play("idle_down")
		animation_preview.play("idle_down")
		yield(get_tree().create_timer(0.1), "timeout")
		animation_parts.stop()
		animation_preview.stop()
