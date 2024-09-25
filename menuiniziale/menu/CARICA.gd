extends Button

var progress_path = "res://salvataggi/salvataggi_progressi/ProgressData.tres"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"






func _on_CARICA_pressed():
	("entro")
	$"../../../../selezione".play()
	var file = File.new()
	if file.file_exists(progress_path):
		Global.load_progress_data()
		Global.load_settings()
		get_tree().change_scene("res://Desktop/Node2D.tscn")
		if(Global.fine_gioco == true):
			Global.switchcolonnasonorachill()
		else:
			Global.switchcolonnasonoraSad()
