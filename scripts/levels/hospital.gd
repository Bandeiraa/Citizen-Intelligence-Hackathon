extends LevelManager

func _ready() -> void:
	DataManagement.data_dictionary.CurrentLevel = "res://scenes/levels/hospital.tscn"
	DataManagement.save_data()
	
	room_dialog = [
		["Olá, este é o hospital, converse com os profissionais.", "", ""], 
		["Conforme você for realizando as atividades, o mural do hospital irá exibir informações sobre a Covid-19.", "", ""], 
		["Boa sorte!", "", ""]
	]
	
	
func verify_saved_data() -> void:
	DataManagement.load_data()
	if DataManagement.data_dictionary.PortalHospital or DataManagement.data_dictionary.Hospital:
		interpolate(initial_spawn_position)
	else:
		instance_dialog()
		
		
func on_tween_completed() -> void:
	instance_player("Hospital")
	
	
func on_level_changed():
	DataManagement.data_dictionary.PortalHospital = true
	DataManagement.save_data()
