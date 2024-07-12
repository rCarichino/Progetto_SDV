extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	$colonnasonorachill.play()


func switchcolonnachill():
	$colonnasonorachill.stream_paused=true
	$".".hide()
