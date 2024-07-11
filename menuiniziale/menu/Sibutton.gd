extends Button



func Nuova_p():
	if Global.file.file_exists("res://salvataggi/salvataggi_impostazioni/global_data.json"):
		Global.file.remove("res://salvataggi/salvataggi_impostazioni/global_data.json")



func _on_Sibutton_pressed():
	get_tree().change_scene("res://Desktop/Node2D.tscn")
