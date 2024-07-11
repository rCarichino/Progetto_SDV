extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _on_rimandopushfoto_pressed():
	get_tree().change_scene("res://Cartella_Foto/CartellaFoto.tscn")
func _on_chiudipushfoto_pressed():
	$".".visible=false
	
func show_notify_foto():
	$".".visible=true
	$AudioStreamPlayer.play()
