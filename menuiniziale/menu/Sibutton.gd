extends Button

var dir = "res://salvataggi/salvataggi_impostazioni/global_data.json"

func Nuova_p():
	var file = File.new()
	if file.file_exists(dir):
		file.file.remove("res://salvataggi/salvataggi_impostazioni/global_data.json")




func _on_Sibutton_pressed():
	Nuova_p()
	get_tree().change_scene("res://Desktop/Node2D.tscn")
