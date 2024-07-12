extends Control

func _ready():
	$ControlChill/colonnasonorachill.play()
	

func switchcolonnaSad():
	$ControlChill/colonnasonorachill.stream_paused=true
	$ControlSad/colonnasonorasad.play()
	$".".show()
