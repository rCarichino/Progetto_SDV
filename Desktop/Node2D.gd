extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

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
			second_dialog.connect("dialogic_signal",self, 'signal_chiamata2')
			
		elif(stato == 3):
			pass
		
		elif(stato == 4):
			var fourth_dialog = Dialogic.start('Scelta3_CentroSportivo')
			add_child(fourth_dialog)
			fourth_dialog.connect("dialogic_signal",self, 'signal_centrosportivo')
			
		
		##scelta prefabbricato successiva alla visita del centro sportivo
		elif(stato == 5):
			var fifth_dialog = Dialogic.start('Scelta1_Prefabbricato')
			add_child(fifth_dialog)
			print("tempo scaduto, alessia morta")
			# nessuna funzione signal perche comprende la morte
		
		##scelta residence successiva alla visita del centro sportivo
		elif(stato == 6):
			var sixth_dialog = Dialogic.start('Scelta2_Residence')
			add_child(sixth_dialog)
			sixth_dialog.connect("dialogic_signal",self, 'signal_residence')
			
			
			
			
			
			
			


	


func after_chiamata1(chiamata1):
		print("fine chiamata numero 1")
		Global.stato_chiamata = 2
		


func after_chiamata2(chiamata2):
		print("fine chiamata numero 2")
		

# in base alla decisione presa in chiamata 2, la terza chiamata puo avere 3 opzioni diverse		
func signal_chiamata2(argument):
		if(argument == 'residence'):
			print("ha scelto residence")
			Global.stato_chiamata = 3
		if(argument == 'centrosportivo'):
			print("ha scelto centrosportivo")
			Global.stato_chiamata = 4
		if(argument == 'prefabbricato'):
			print("ha scelto prefabbricato")
		##	Global.stato_chiamata = 5


#sei al centro sportivo, in base alla scelta vai a prefabbricato o a residence			
func signal_centrosportivo (arg):
	if arg == 'centro_to_pref':
		print("va da centro sportivo a prefabbricato")
		Global.stato_chiamata = 5
	elif arg =='centro_to_residence':
		print("va da centro sportivo a residence")
		Global.stato_chiamata = 6

#sei al residence dopo il centro, in base alla scelta vai a teatro, app, o rece
func signal_residence(arg):
	if arg == 'residence_teatro':
		print("va nel teatro del residence")
	if arg == 'residence_reception':
		print("va nella reception del residence")
	if arg == 'residence_appartamenti':
		print("va negli appartamenti del residence")

func _on_door_mouse_exited():
	pass # Replace with function body.


func _on_Si_mouse_exited():
	pass # Replace with function body.
