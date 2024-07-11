extends Button

var dir = "res://salvataggi/salvataggi_impostazioni/global_data.json"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if not file.file_exists(dir):
		$".".disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CARICA_pressed():
	$"../../../../selezione".play()
	var file = File.new()
	if file.file_exists(dir) :
		Global.load_global_data()
