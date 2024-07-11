extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass




func _on_chiudipushdiario_pressed():
	$".".visible=false
	pass # Replace with function body.

func show_notify_diario():
	$".".visible=true
	$AudioStreamPlayer.play()
