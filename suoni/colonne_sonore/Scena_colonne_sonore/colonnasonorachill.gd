extends Control

func _ready():
	$ControlChill/colonnasonorachill.play()
	

func switchcolonnaSad():
	$ControlChill/colonnasonorachill.stream_paused=true
	$ControlSad/colonnasonorasad.play()
	$".".show()


func switchcolonnachill():
	$ControlSad/colonnasonorasad.stream_paused=true
	$ControlChill/colonnasonorachill.play()
