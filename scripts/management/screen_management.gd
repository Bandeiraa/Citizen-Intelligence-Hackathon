extends CanvasLayer

onready var display_song: TextureRect = get_node("DisplaySong")
onready var animation: AnimationPlayer = get_node("Container/Animation")
onready var song_anim: AnimationPlayer = get_node("DisplaySong/Animation")

var tracks: Array = ["nao sei o que voce viu em mim", "heat waves", "menina se prepara"]

var target_level: String

signal start_level

func _ready() -> void:
	fade_out()
	
	
func fade_in(level: String) -> void:
	target_level = level
	animation.play("fade_in")
	
	
func fade_out() -> void:
	animation.play("fade_out")
	
	
func update_music(song: String) -> void:
	display_song.texture = load("res://assets/user_interface/sound_name/" + tracks[tracks.find(song)] + ".png")
	song_anim.play("show_anim")
	
	
func on_animation_finished(anim_name) -> void:
	match anim_name:
		"fade_in":
			var _change_scene = get_tree().change_scene(target_level)
			fade_out()
			
		"fade_out":
			emit_signal("start_level")
			
