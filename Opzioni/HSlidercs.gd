extends HSlider

var music = AudioServer.get_bus_index("Colonna_Sonora")

func _ready():
	$".".value = 0.09




func _on_HSlidercs_value_changed(value):
	AudioServer.set_bus_volume_db(music, linear2db(value))
