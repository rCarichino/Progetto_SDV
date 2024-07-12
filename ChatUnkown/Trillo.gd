extends Button



func _on_Trillo_pressed():
	Global.trillo = true
	$AudioStreamPlayer.play()
