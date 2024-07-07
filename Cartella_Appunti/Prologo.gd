extends TextureButton
#funzioni per il doppio click e il cambio cursore (da copiare per le altre icone)
signal double_click

var double_speed: int = 1000*0.25
var last_click: = 0.0
var selected = false
var of = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed",self,"on_pressed")
	connect("double_click",self, "on_double_click")

func double_click_detect():
		var new_click: = OS.get_ticks_msec()
		if new_click - last_click <= double_speed:
				return true
		last_click = new_click
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Prologo_pressed():
	if double_click_detect():
		get_tree().change_scene("res://Cartella_Appunti/File Diario/Prologo.tscn")
