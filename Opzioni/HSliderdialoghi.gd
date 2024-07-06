extends HSlider

var music = AudioServer.get_bus_index("Dialoghi")

func _ready():
	$".".value = 0.09





func _on_HSliderdialoghi_value_changed(value):
	AudioServer.set_bus_volume_db(music, linear2db(value))
