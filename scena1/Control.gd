extends Control
#funzioni per la visualizzazione di door e la chiusura del programma(script in controllaspegnimento)
#lasciare sprite,spegni e controllaspegnimento sempre invisibili

func _process(delta):
	pass


func _on_door_pressed():
	if $door/Sprite.visible == false: 
		$door/Sprite.visible = true 
		$door/riavvio.visible = true
		$door/arresto.visible = true
		$door/sospendi.visible = true
	elif $door/Sprite.visible == true:
		$door/Sprite.visible = false 
		$door/riavvio.visible = false
		$door/arresto.visible = false
		$door/sospendi.visible = false



func _on_arresto_pressed():
	$door/arresto/Controlarresto.visible = true


func _on_riavvio_pressed():
	$door/riavvio/Controlriavvio.visible = true


func _on_sospendi_pressed():
	 $door/sospendi/Controlsospendi.visible = true



