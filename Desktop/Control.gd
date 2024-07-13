extends Control
#funzioni per la visualizzazione di door e la chiusura del programma(script in controllaspegnimento)
#lasciare sprite,spegni e controllaspegnimento sempre invisibili



func _ready():
	if(Global.chat_tictac == true && Global.tictac_displayed == false):
		Global.tictac_displayed = true
		$Controlpushmsn.show()
	if(Global.chat_10minuti == true && Global.chat10_displayed == false):
		Global.chat10_displayed = true
		$Controlpushmsn.show()
	if(Global.chat_5minuti == true && Global.chat5_displayed == false):
		Global.chat5_displayed = true
		$Controlpushmsn.show()

			
func _on_door_mouse_exited():
	pass # Replace with function body.


func _on_Si_mouse_exited():
	pass # Replace with function body.

# warning-ignore:unused_argument
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



