extends Control
#funzioni per la visualizzazione di door e la chiusura del programma(script in controllaspegnimento)
#lasciare sprite,spegni e controllaspegnimento sempre invisibili




# Called when the node enters the scene tree for the first time.
func _ready():
		print("ciao control")
		print(Global.stato_chiamata)
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
			
		
		#scelta residence come primo luogo da visitare	
		elif(stato == 3):
			Global.residence_as_first = true
			var third_dialog = Dialogic.start('Scelta2_Residence')
			add_child(third_dialog)
			third_dialog.connect("timeline_end", self, 'Scelta2_Residence')
			third_dialog.connect("dialogic_signal",self, 'signal_residence')
		
			
		
		#scelta centro sportivo come primo posto da visitare
		elif(stato == 4):
			var fourth_dialog = Dialogic.start('Scelta3_CentroSportivo')
			add_child(fourth_dialog)
			fourth_dialog.connect("dialogic_signal",self, 'signal_centrosportivo')
			
		
		#scelta prefabbricato successiva alla visita del centro sportivo
		elif(stato == 5):
			var fifth_dialog = Dialogic.start('Scelta1_Prefabbricato')
			add_child(fifth_dialog)
			Global.residence_as_first = false
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
			Global.residence_as_first = false
			print("alessia morta")
			#nessuna funzione signal perche comprende la morte
			

		#reception del residence
		elif (stato == 8):
			var eighth_dialog = Dialogic.start('reception_first')
			add_child(eighth_dialog)
			Global.residence_as_first = false
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
			Global.residence_as_first = false
			print("alessia morta")
			#nessun signal perche comprende la morte
			
		
		
		#scelta teatro del residence, se si è scelto il residence per primo	
		elif(stato == 13):
			var dialog_13 = Dialogic.start('teatro_positivo')
			add_child(dialog_13)
			dialog_13.connect("dialogic_signal",self, 'signal_teatropositivo')
			
		#scelta reception, se si arriva da teatro e si è scelto residence per primo	
		elif(stato == 14):
			var dialog_14 = Dialogic.start('reception_1')
			add_child(dialog_14)
			Global.stato_chiamata = 9 #perchè puoi andare solo agli appartamenti
		
		#scelta reception del residence, se si è scelto il residence per primo	
		elif(stato == 15):
			var dialog_15 = Dialogic.start('reception_positivo')
			add_child(dialog_15)
			dialog_15.connect("dialogic_signal",self, 'signal_receptionpositivo')
			
		#scelto teatro del residence, se si è stati prima alla reception e si è scelto residence x primo
		elif(stato == 16):
			var dialog_16 = Dialogic.start('teatro_post_reception')
			add_child(dialog_16)
			Global.stato_chiamata = 9 #perchè puoi andare solo agli appartamenti
		
			

	


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




#sei al residence dopo il centro, in base alla scelta vai a teatro, app, o reception
func signal_residence(arg):
	if(Global.residence_as_first == true):
		print("hai scelto residence per primo")
		if arg == 'residence_teatro':
			print("va nel teatro del residence")
			Global.stato_chiamata = 13
		if arg == 'residence_reception':
			print("va nella reception del residence")
			Global.stato_chiamata = 15
		if arg == 'residence_appartamenti':
			print("va negli appartamenti del residence")
			Global.stato_chiamata = 9

		
	else:
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
			




#sei al residence come primo luogo e sei andato a teatro, puoi andare a reception o appartamenti			
func signal_teatropositivo(arg):
		if arg == 'teatro_to_reception':
			Global.stato_chiamata = 14
		if arg == 'teatro_to_appartamenti':
			Global.stato_chiamata = 9




#sei al residence come primo luogo e sei andato in reception, puoi andare a teatro o appartamenti			
func signal_receptionpositivo(arg):
		if arg == 'reception_to_teatro':
			Global.stato_chiamata = 16
		if arg == 'reception_to_appartamenti':
			Global.stato_chiamata = 9
			


			
func _on_door_mouse_exited():
	pass # Replace with function body.


func _on_Si_mouse_exited():
	pass # Replace with function body.

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



