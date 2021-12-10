extends LevelManager

func _ready() -> void:
	DataManagement.data_dictionary.CurrentLevel = "res://scenes/levels/character_room.tscn"
	DataManagement.save_data()
	
	room_dialog = [
		["Instruções do Jogo: Pressione Enter ao final de uma mensagem para ir a mensagem seguinte.", "", ""], 
		["Pressione e segure Enter para acelerar a velocidade na qual a mensagem aparece.", "", ""], 
		["A ou Seta Esquerda -> Andar para a Esquerda.", "", ""],
		["D ou Seta Direita -> Andar para a Direita.", "", ""],
		["W ou Seta Cima -> Andar para Cima.", "", ""],
		["S ou Seta Baixo -> Andar para Baixo.", "", ""],
		["E -> Interagir.", "", ""],
		["Bom jogo, espero que goste!", "", ""]
	]
	
	
func verify_saved_data() -> void:
	DataManagement.load_data()
	if DataManagement.data_dictionary.PortalRoom:
		interpolate(Vector2(192, 212))
	elif DataManagement.data_dictionary.Room:
		interpolate(Vector2(52, 52))
	else:
		instance_dialog()
		
		
func on_tween_completed() -> void:
	instance_player("Room")
	
	
func on_level_changed():
	DataManagement.data_dictionary.PortalRoom = true
	DataManagement.save_data()
