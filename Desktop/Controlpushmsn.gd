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


func _on_chiudipushdiario_pressed():
	$".".hide()


func _on_rimandopushdiario_pressed():
	get_tree().change_scene("res://Cartella_Appunti/CartellaAppunti.tscn")


func _on_rimandopushdiario2_pressed():
	get_tree().change_scene("res://Cartella_Appunti/CartellaAppunti.tscn")
