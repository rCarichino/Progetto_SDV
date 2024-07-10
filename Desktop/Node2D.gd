extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	while(true):
		if(Global.chat_completed == true):
			seleziona_chiamata(Global.stato_chiamata)
	
	
func seleziona_chiamata(stato):
		if(stato == 1):
			var new_dialog = Dialogic.start('chiamata1')
			add_child(new_dialog)
			new_dialog.connect("timeline_end", self, 'after_chiamata1')
			
		elif(stato == 2):
			var second_dialog = Dialogic.start('chiamata2')
			add_child(second_dialog)
			second_dialog.connect("timeline_end", self, 'after_chiamata2')
			
		elif(stato == 3):
			pass
			
			
			
			


	


func after_chiamata1(chiamata1):
		print("fine chiamata numero 1")
		Global.stato_chiamata = 2
		


func after_chiamata2(chiamata2):
		print("fine chiamata numero 2")
		Global.stato_chiamata = 3

func _on_door_mouse_exited():
	pass # Replace with function body.


func _on_Si_mouse_exited():
	pass # Replace with function body.
