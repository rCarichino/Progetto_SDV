extends Node2D

func _ready():    
	# Recupera il VideoPlayer dalla scena
	var video_player = $VideoPlayer
	
	# Avvia il video se non è impostato su autoplay
	if not video_player.autoplay:
		video_player.play()


func _on_VideoPlayer_finished():
		get_tree().change_scene("res://menuiniziale/menu/menuiniziale.tscn")

