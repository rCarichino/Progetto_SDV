extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_rimandopushmsn_pressed():
	get_tree().change_scene("res://ChatIniziale/messanger.tscn")

func _on_chiudipushmsn_pressed():
	$".".visible=false
	pass # Replace with function body.

func show_notify():
	$".".visible=true
	$AudioStreamPlayer.play()
