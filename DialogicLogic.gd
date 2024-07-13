extends Node

func seleziona_chiamata(stato):
	Global.timer_expired = false
	
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
		Global.fine_gioco = true
		Global.save_progress_data()


		#scelta residence successiva alla visita del centro sportivo o prefabbricato
	elif(stato == 6):
		var sixth_dialog = Dialogic.start('Scelta2_Residence')
		add_child(sixth_dialog)
		sixth_dialog.connect("dialogic_signal",self, 'signal_residence')
			
		#teatro del residence	
	elif(stato == 7):
		var seventh_dialog = Dialogic.start('teatro_first')
		add_child(seventh_dialog)
		Global.fine_gioco = true
		Global.save_progress_data()
			
		#reception del residence
	elif (stato == 8):
		var eighth_dialog = Dialogic.start('reception_first')
		add_child(eighth_dialog)
		Global.save_progress_data()
			
		#appartamenti del residence inizio
	elif (stato == 9):
		var ninth_dialog = Dialogic.start('appartamenti_inizio')
		add_child(ninth_dialog)
		Global.chat_trillo_esca = true
		Global.stato_chiamata = 10 
		#appartamenti del residence fine
	elif(stato == 10):
		var tenth_dialog = Dialogic.start('appartamenti_fine')
		add_child(tenth_dialog)
		Global.fine_gioco = true
		Global.save_progress_data()
		
		#scelta del prefabbricato come primo luogo da visitare
	elif(stato == 11):
		var dialog_11 = Dialogic.start('prefabbricato_2')
		add_child(dialog_11)
		dialog_11.connect("dialogic_signal",self, 'signal_prefabbricato')
			
			
		#scelta del centro sportivo dopo esser andato al prefabbricato
	elif(stato == 12):
		var dialog_12 = Dialogic.start('centro_sportivo_morte')
		add_child(dialog_12)
		Global.fine_gioco = true
		Global.save_progress_data()




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
		Global.fake_call_timer(10)
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
		Global.fake_call_timer(10)

	if(Global.residence_as_first == false && Global.stato_chiamata > 2):
		print(Global.step)
		match Global.step:
			0:
				Global.chat_10minuti = true
			1:
				Global.chat_5minuti = true
		Global.step = Global.step + 1


func after_chiamata1(chiamata1):
	Global.chiamata_1_finita = true

	Global.stato_chiamata = 2
	Global.restore_volume()


# warning-ignore:unused_argument
func after_chiamata2(chiamata2):
	Global.restore_volume()


# in base alla decisione presa in chiamata 2, la terza chiamata puo avere 3 opzioni diverse		
func signal_chiamata2(argument):
	if(argument == 'residence'):
		Global.mappa = "Residence"
		Global.stato_chiamata = 3
		Global.residence_as_first = true
		Global.fake_call_timer(10)
	if(argument == 'centrosportivo'):
		Global.mappa = "CentroSportivo"
		Global.stato_chiamata = 4
		Global.chat_tictac = true
	if(argument == 'prefabbricato'):
		Global.mappa = "Prefabbricato"
		Global.stato_chiamata = 11
		Global.chat_tictac = true

	Global.restore_volume()

#sei al centro sportivo, in base alla scelta vai a prefabbricato o a residence			
func signal_centrosportivo (arg):
	if arg == 'centro_to_pref':
		Global.mappa = "Prefabbricato"
		Global.stato_chiamata = 5
	elif arg =='centro_to_residence':
		Global.mappa = "Residence"
		Global.stato_chiamata = 6
	Global.restore_volume()

#sei al residence dopo il centro, in base alla scelta vai a teatro, app, o reception
func signal_residence(arg):
	if(Global.residence_as_first == true):

		if arg == 'residence_teatro':

			Global.stato_chiamata = 13
		if arg == 'residence_reception':

			Global.stato_chiamata = 15
		if arg == 'residence_appartamenti':
			
			Global.stato_chiamata = 9
		Global.fake_call_timer(10)
		
	else:
		if arg == 'residence_teatro':

			Global.stato_chiamata = 7
		if arg == 'residence_reception':

			Global.stato_chiamata = 8
		if arg == 'residence_appartamenti':

			Global.stato_chiamata = 9
	Global.restore_volume()


#sei al prefabbricato come primo luogo, in base alla scelta vai a residence o centro sportivo
func signal_prefabbricato(arg):
	if arg == 'prefabbricato_to_residence':
		Global.mappa = "Residence"
		Global.stato_chiamata = 6
	if arg == 'prefabbricato_to_centrosportivo':
		Global.mappa = "CentroSportivo"
		Global.stato_chiamata = 12
	Global.restore_volume()




#sei al residence come primo luogo e sei andato a teatro, puoi andare a reception o appartamenti			
func signal_teatropositivo(arg):
	if arg == 'teatro_to_reception':
		Global.stato_chiamata = 14
	if arg == 'teatro_to_appartamenti':
		Global.stato_chiamata = 9
	Global.fake_call_timer(10)
	Global.restore_volume()


#sei al residence come primo luogo e sei andato in reception, puoi andare a teatro o appartamenti			
func signal_receptionpositivo(arg):
	if arg == 'reception_to_teatro':
		Global.stato_chiamata = 16
	if arg == 'reception_to_appartamenti':
		Global.stato_chiamata = 9
	Global.fake_call_timer(10)
	Global.restore_volume()
