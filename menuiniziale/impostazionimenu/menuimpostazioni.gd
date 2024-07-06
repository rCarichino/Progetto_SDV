extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HSliderdialoghiMenu_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.getbus_index("Dialoghi"),linear2db(value))
	AudioServer.set_bus_mute(AudioServer.getbus_index("Dialoghi"), value<0.05)


func _on_HSlidereffettiMenu_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.getbus_index("Effetti"),linear2db(value))
	AudioServer.set_bus_mute(AudioServer.getbus_index("Effetti"), value<0.05)
