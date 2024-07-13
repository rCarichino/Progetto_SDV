extends Control

func _ready():
	$ControlChill/colonnasonorachill.play()
	$ControlSad/colonnasonorasad.play()
	$ControlSad/colonnasonorasad.stream_paused=true

func switchcolonnaSad():
	$ControlChill/colonnasonorachill.stream_paused=true
	$ControlSad/colonnasonorasad.stream_paused= false
	$".".show()

func switchcolonnachill():
	$ControlSad/colonnasonorasad.stream_paused=true
	$ControlChill/colonnasonorachill.stream_paused=false
	$".".show()
