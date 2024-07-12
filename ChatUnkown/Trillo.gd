extends Button



func _on_Trillo_pressed():
	$AudioStreamPlayer.play()
	if(Global.trillo_unloked_rapitore == true):
		Global.trillo = true
		Global.fake_call_timer(10)
