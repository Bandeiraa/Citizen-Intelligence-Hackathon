extends AudioStreamPlayer

var tracks: Array =  ["nao sei o que voce viu em mim", "heat waves", "menina se prepara"]
var previous_song: String = ""

func random_song() -> void:
	randomize()
	tracks.shuffle()
	var audiostream: AudioStream = load("res://assets/soundtrack/" + tracks.front() + ".mp3")
	previous_song = tracks.front()
	get_tree().call_group("Interface", "update_music", previous_song)
	tracks.remove(tracks.front())
	tracks.append(previous_song)
	set_stream(audiostream)
	play()
	
	
func on_bgm_finished() -> void:
	get_tree().call_group("Amplifier", "stop_anim")
	#random_song()
