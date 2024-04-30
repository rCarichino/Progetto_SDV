extends Control
#funzioni per la visualizzazione di door e la chiusura del programma(script in controllaspegnimento)
#lasciare sprite,spegni e controllaspegnimento sempre invisibili

func _process(delta):
	pass


func _on_door_pressed():
	if $door/Sprite.visible == false:
		$door/Sprite.visible = true
	elif $door/Sprite.visible == true:
		$door/Sprite.visible = false
	if $door/SPEGNI.visible == false:
		$door/SPEGNI.visible = true
	elif $door/SPEGNI.visible == true:
		$door/SPEGNI.visible = false


func _on_SPEGNI_pressed():
	$door/SPEGNI/Controlspegni.visible = true
	

