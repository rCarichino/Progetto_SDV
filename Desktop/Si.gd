extends Button
var dir = "res://salvataggi/salvataggi_progressi/progressi_data.json"
var dirimp = "res://salvataggi/salvataggi_impostazioni/settings_data.json"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Siriavv_pressed():
	var file = File.new()
	var file2 = File.new()
	if file.file_exists(dir) && file2.file_exists(dirimp):
		Global.load_global_data()
		Global.load_settings()
		get_tree().change_scene("res://Desktop/Node2D.tscn")
