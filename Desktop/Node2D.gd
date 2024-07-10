extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
		print(Global.stato_chiamata)
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
		
		#scelta centro sportivo come primo posto da visitare
		elif(stato == 4):
			var fourth_dialog = Dialogic.start('Scelta3_CentroSportivo')
			add_child(fourth_dialog)
			fourth_dialog.connect("dialogic_signal",self, 'signal_centrosportivo')
			
		
		#scelta prefabbricato successiva alla visita del centro sportivo
		elif(stato == 5):
			var fifth_dialog = Dialogic.start('Scelta1_Prefabbricato')
			add_child(fifth_dialog)
			print("tempo scaduto, alessia morta")
			# nessuna funzione signal perche comprende la morte
			
			
		
		#scelta residence successiva alla visita del centro sportivo o prefabbricato
		elif(stato == 6):
			var sixth_dialog = Dialogic.start('Scelta2_Residence')
			add_child(sixth_dialog)
			sixth_dialog.connect("dialogic_signal",self, 'signal_residence')
			
			
		
		#teatro del residence	
		elif(stato == 7):
			var seventh_dialog = Dialogic.start('teatro_first')
			add_child(seventh_dialog)
			print("alessia morta")
			#nessuna funzione signal perche comprende la morte
			

		#reception del residence
		elif (stato == 8):
			var eighth_dialog = Dialogic.start('reception_morte')
			add_child(eighth_dialog)
			print("alessia morta")
			

		#appartamenti del residence inizio
		elif (stato == 9):
			var ninth_dialog = Dialogic.start('appartamenti_inizio')
			add_child(ninth_dialog)
			print("prima parte appartamenti...")
			#da togliere, in realta si passa alla seconda parte solo dopo che vai su MSN e mandi il trillo!
			Global.stato_chiamata = 10 
			
		
		#appartamenti del residence fine
		elif(stato == 10):
			var tenth_dialog = Dialogic.start('appartamenti_fine')
			add_child(tenth_dialog)
			print("seconda parte appartamenti, Alessia salvata!")
			
		
		#scelta del prefabbricato come primo luogo da visitare
		elif(stato == 11):
			var dialog_11 = Dialogic.start('prefabbricato_2')
			add_child(dialog_11)
			dialog_11.connect("dialogic_signal",self, 'signal_prefabbricato')
			
		#scelta del centro sportivo dopo esser andato al prefabbricato
		elif(stato == 12):
			var dialog_12 = Dialogic.start('centro_sportivo_morte')
			add_child(dialog_12)
			print("alessia morta")
			#nessun signal perche comprende la morte
			
	
			
			# DA FARE: implementazione percorso del Residence come prima scelta
			#(in quel caso non si muore andando a teatro o reception prima)
			
			


	


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
			Global.stato_chiamata = 11






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
		Global.stato_chiamata = 7
	if arg == 'residence_reception':
		print("va nella reception del residence")
		Global.stato_chiamata = 8
	if arg == 'residence_appartamenti':
		print("va negli appartamenti del residence")
		Global.stato_chiamata = 9



#sei al prefabbricato come primo luogo, in base alla scelta vai a residence o centro sportivo
func signal_prefabbricato(arg):
		if arg == 'prefabbricato_to_residence':
			print("va da prefabbricato a residence")
			Global.stato_chiamata = 6
		if arg == 'prefabbricato_to_centrosportivo':
			print("va da prefabbricato a centro sportivo")
			Global.stato_chiamata = 12
			
func _on_door_mouse_exited():
	pass # Replace with function body.


func _on_Si_mouse_exited():
	pass # Replace with function body.
