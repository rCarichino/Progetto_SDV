extends Control

var MessaggioRicevuto = preload("res://bubbleRicevuto/Speech.tscn")
var MessaggioInviato  = preload("res://bubbleInvio/Speech.tscn")
var ReceivedImageBubble = preload("res://bubbleImmagine/ImageBubble.tscn")  # Carica la nuova scena

onready var scroll_container = $HBoxContainer/ChatContainer/ScrollContainer
onready var message_container = $HBoxContainer/ChatContainer/ScrollContainer/VBoxContainer

func _ready():
	if(Global.fine_prologo == true):
		$HBoxContainer/ChatListContainer/ItemList.add_item("User_454234", preload("res://icone/imgRapitore64.png"))
	
	create_spacer()
	
	if(Global.chat_messages_rapitore == []):
		add_received_message(Global.chat_rapitore_to_jimmy_atto1[0])
		create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[0]])
	else:
		load_messages()
		check_where_stopped()

func scroll_to_bottom():
	scroll_container.scroll_vertical = scroll_container.get_v_scrollbar().max_value

func add_sent_message(text):
	var found = false
	var bubble = MessaggioInviato.instance()
	bubble.bubble_text = text

	bubble.get_node("VBoxContainer").margin_right = -50

	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGN_END  
	
	var spacer_left = Control.new()
	spacer_left.rect_min_size = Vector2(0, 70)
	spacer_left.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	
	var message_container_right = VBoxContainer.new()
	message_container_right.add_child(bubble)
	hbox.add_child(spacer_left)
	hbox.add_child(message_container_right)
	message_container.add_child(hbox)
	yield(get_tree().create_timer(0.3),"timeout")
	scroll_to_bottom()
	
	if(Global.chat_messages_rapitore != []):
		for message in Global.chat_messages_rapitore:
			if text in message["text"]:
				found = true
				break
		if(!found):
			Global.add_message_rapitore({"type": "sent", "text": text})
	else:
		Global.add_message_rapitore({"type": "sent", "text": text})

func add_received_message(text):
	var found = false
	var bubble = MessaggioRicevuto.instance()
	bubble.bubble_text = text

	bubble.get_node("VBoxContainer").margin_left = 30
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGN_BEGIN 
	
	var message_container_left = VBoxContainer.new()
	message_container_left.add_child(bubble)
	var spacer_right = Control.new()
	spacer_right.rect_min_size = Vector2(0, 70)
	spacer_right.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	
	hbox.add_child(message_container_left)
	hbox.add_child(spacer_right)
	message_container.add_child(hbox)
	yield(get_tree().create_timer(0.3),"timeout")
	scroll_to_bottom()
	
	if(Global.chat_messages_rapitore != []):
		for message in Global.chat_messages_rapitore:
			if text in message["text"]:
				found = true
				break
		if(!found):
			Global.add_message_rapitore({"type": "received", "text": text})
	else:
		Global.add_message_rapitore({"type": "received", "text": text})


func create_phrase_buttons(phrases):
	var vbox = $HBoxContainer/ChatContainer/HBoxContainer/VBoxContainer
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()

	for i in range(len(phrases)):
		var phrase = phrases[i]
		var button = Button.new()
		button.flat = true
		button.text = phrase
		
		# Imposta il puntatore a pointing hand
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		
		# Imposta lo stile del bottone
		var style_normal = StyleBoxFlat.new()
		style_normal.bg_color = Color(0, 0, 0, 0)
		
		var style_hover = StyleBoxFlat.new()
		style_hover.bg_color = Color(0, 0, 0, 0)
		
		var style_pressed = StyleBoxFlat.new()
		style_pressed.bg_color = Color(0, 0, 0, 0)
		
		var style_focus = StyleBoxEmpty.new()
		
		button.add_stylebox_override("normal", style_normal)
		button.add_stylebox_override("hover", style_hover)
		button.add_stylebox_override("pressed", style_pressed)
		button.add_stylebox_override("focus", style_focus)
		button.add_color_override("font_color", Color.black)
		button.add_color_override("font_color_hover", Color.black)
		button.add_color_override("font_color_pressed", Color.black)
		button.connect("pressed", self, "_on_phrase_button_pressed", [button, phrase])
		vbox.add_child(button)

		# Aggiungi una linea di separazione tra i bottoni
		if i < len(phrases) - 1:
			var separator = HSeparator.new()
			separator.rect_min_size = Vector2(0, 2)
			separator.modulate = Color(0, 0, 0)
			vbox.add_child(separator)


func _on_phrase_button_pressed(button,phrase):

	if(phrase == "[Chiama Alessia]" || phrase == "[Chiama la polizia]"):
		disable_all_buttons()
		button.disabled =  true
		give_answer(phrase)
	else:
		add_sent_message(phrase)
		disable_all_buttons()
		button.disabled =  true
		give_answer(phrase)


func disable_all_buttons():
	var vbox = $HBoxContainer/ChatContainer/HBoxContainer/VBoxContainer
	for child in vbox.get_children():
		if child is Button:
			child.disabled = true


func give_answer(question):
	match question:
		"? k 6???? Cm sai k é Alessia":

			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[1])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[1],Global.chat_jimmy_to_rapitore_atto1[2]])
			
		"nn intendo cadere in 1 di qst truffe online":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[2])
			yield(get_tree().create_timer(2),"timeout")
			add_received_image("res://fotoAlessia/foto_n1_chat.jpg")
			$NotificaFoto.show_notify_foto()
			Global.modify_foto1()
			yield(get_tree().create_timer(1),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[3])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[4])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
		"In k senso?":
			yield(get_tree().create_timer(1),"timeout")
			add_received_image("res://fotoAlessia/foto_n1_chat.jpg")
			$NotificaFoto.show_notify_foto()
			Global.modify_foto1()
			yield(get_tree().create_timer(1),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[3])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[4])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])

		"Va bene come vuoi tu, non farle del male perfavore":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[9])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])

		"Ok ma cosa vuoi da noi":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[10])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])

		"[Chiama la polizia]":
			var finalePolizia = Dialogic.start('finale polizia')
			add_child(finalePolizia)


		"[Chiama Alessia]":
			##far partire uno squillo
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[11])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])

		"Va bene…":
			if(Global.sblocco_atto2_rapitore == true):
				Global.not_already_notified_carlo()
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[0])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[1])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[2])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[3])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0], 
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
			else:
				Global.modify_fine_atto1()
				if(Global.already_notified_rapitore == false):
					$NotificaMSN.show_notify()
					$NotificaDiario.show_notify_diario()
					Global.yes_already_notified_rapitore()
					Global.save_progress_data()

	if(Global.sblocco_atto2_rapitore == true):
		match question:
			"Non ho tutti quei soldi":
				Global.not_already_notified_rapitore()
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[6])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[3]])
				
			"Come fai a sapere dove abito?":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[7])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[4]])
				
			"Come posso fidarmi di te?\n Dopo che ti avrò dato i soldi libererai mia sorella?":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[8])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[5]])
				
			"Ti sto dicendo la verità, non ho tutti quei soldi","In ogni caso non ho tutti quei soldi",\
			"Non ho scelta ma non neanche tutti quei soldi":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[9])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[6]])
				Global.modify_sblocco_atto2_carlo()

				if(Global.already_notified_rapitore == false):
					$NotificaMSN.show_notify()
					Global.yes_already_notified_rapitore()
					
			"Ok, dammi un po’ di tempo che trovo i soldi":
				Global.not_already_notified_rapitore()
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[10])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[7]])
			"Io li cerco, ma tu non toccarla":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[11])
				Global.modify_fine_atto2_rapitore()
				if(Global.fine_atto2_carlo == true && Global.fine_atto2_rapitore == true):
					Global.modify_fine_atto2()
					Global.chat_completed = true
					if(Global.chiamata_1_finita == false || Global.already_started == false):
						Global.already_started = true
						Global.fake_call_timer(10)
						if(Global.already_notified_rapitore == false):
							$NotificaDiario.show_notify_diario()
							Global.yes_already_notified_rapitore()

						
	if(Global.chiamata_1_finita):
		match question:
			"Ma mandami una sua foto ti prego,\nvoglio sapere se sta bene","Mandami però una sua foto,\nvoglio capire se sta bene":
				yield(get_tree().create_timer(2),"timeout")
				add_received_image("res://fotoAlessia/foto_n2_chat.jpg")
				$NotificaFoto.show_notify_foto()
				Global.modify_foto2()
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[1])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[2])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[2]])
			"Va bene, cosa devo fare?":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[3])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[3]])
			"Ok…":
				Global.chat_1_finita = true

				if(Global.chat_tictac == true):
					print("entra")
					yield(get_tree().create_timer(2),"timeout")
					add_received_message(Global.chat_rapitore_to_jimmy_atto3[4])
					yield(get_tree().create_timer(2),"timeout")
					create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[4]])
				elif(Global.chat_trillo_esca == true):
					yield(get_tree().create_timer(2),"timeout")
					create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[7]])
				elif(Global.fine_seconda_chiamata == false):
					Global.fake_call_timer(10)
					Global.fine_seconda_chiamata = true

	if(Global.chat_tictac == true):
		match question:
			"Ho tutto quello che mi hai chiesto,\n adesso devo metterli insieme":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[4])
				Global.fake_call_timer(10)
	if(Global.chat_10minuti == true):
		match question:
			"E’ tutto pronto, dammi un attimo":

				if(Global.chat_5minuti == true):
					yield(get_tree().create_timer(2),"timeout")
					add_received_message(Global.chat_rapitore_to_jimmy_atto3[6])
					yield(get_tree().create_timer(2),"timeout")
					create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[5]])
				else:
					Global.fake_call_timer(10)
	if(Global.chat_5minuti == true):
		match question:
			"E’ tutto pronto":
				if(Global.chat_trillo_esca == true):
					yield(get_tree().create_timer(2),"timeout")
					add_received_message(Global.chat_rapitore_to_jimmy_atto3[7])
					Global.trillo_unloked_rapitore = true
				else:
					Global.fake_call_timer(10)
	if(Global.chat_trillo_esca == true):
		match question:
			"A che punto è il tuo contatto?":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[7])
				Global.trillo_unloked_rapitore = true


func load_messages():
	# Carica i messaggi dal singleton
	for message in Global.get_messages_rapitore():
		if message["type"] == "sent":
			add_sent_message(message["text"])
		elif message["type"] == "received":
			add_received_message(message["text"])
		elif message["type"] == "received_image":
			add_received_image(message["text"])

func create_spacer():
	var spacer = Control.new()
	spacer.rect_min_size = Vector2(0, 50)  # Altezza minima dello spacer
	spacer.set_v_size_flags(Control.SIZE_EXPAND_FILL)
	message_container.add_child(spacer)

func check_where_stopped():

	var length = Global.chat_messages_rapitore.size()
	var question = ""
	if(Global.chat_messages_rapitore[length-1].type == "received" || Global.chat_messages_rapitore[length-1].type == "received_image"):
		question = Global.chat_messages_rapitore[length-1].text
		load_answer(question)
	elif(Global.chat_messages_rapitore[length-1].type == "sent"):
		question = Global.chat_messages_rapitore[length-1].text
		give_answer(question)
	

func load_answer(question):

	match question:
		"Ciao Jimmy, come sta Alessia?":
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[0]])
			
		"Beh, effettivamente come potresti saperlo! É qui con me":
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[1],Global.chat_jimmy_to_rapitore_atto1[2]])
			
		"Pensi che ti stia prendendo per il culo?":
			yield(get_tree().create_timer(1),"timeout")
			add_received_image("res://fotoAlessia/foto_n1_chat.jpg")
			yield(get_tree().create_timer(1),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[3])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[4])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
			
		"res://fotoAlessia/foto_n1_chat.jpg":
			yield(get_tree().create_timer(1),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[3])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[4])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
		"Non ti azzardare a contattare qualcuno":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[4])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
		"Chiamare la polizia o a muoverti da quella di sedia":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
		"Se non ho tue risposte entro 5 minuti":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
		"Alessia raggiunge mamma e papà.":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[7])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
		"E vedi di scrivere in modo decente…":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[8])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])

		"Se ascolterai tutto quello che ti dico,\nforse non le accadrá nulla", \
		"Lo scoprirai molto presto,\n per ora ascolta tutto quello che ti dico",\
		"Inutile che provi a chiamare":
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])
	if(Global.sblocco_atto2_rapitore == true):
		match question:
			
			"Adesso è arrivato il momento di dimostrare\n quanto ci tieni a tua sorella.":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[1])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[2])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[3])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0],
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
				
			"Voglio 20 mila euro in contanti":  
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[2])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[3])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0],
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
				
			"Dovrai lasciare i soldi vicino casa tua":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[3])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0],
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
				
				
			"E alle ore 18.30 passerà un mio contatto a ritirarli.":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0],
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
				
				
			"Non devi assolutamente avere niente\n a che fare con il contatto" :
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0],
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
				
			"Altrimenti succederà qualcosa a tua sorella":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[0],
				Global.chat_jimmy_to_rapitore_atto2[1],Global.chat_jimmy_to_rapitore_atto2[2]])
				
			"Perchè mi stai mentendo?\n Non tieni abbastanza a tua sorella a quanto pare":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[3]])
				
			"Non ti interessa":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[4]])
				
			"Non credo tu abbia altra scelta":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[5]])
				
			"Conosco benissimo la storia della tua famiglia,\n non trovare scuse":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[6]])
				Global.modify_sblocco_atto2_carlo()
				
			"Ricordati che la vita di tua sorella è nelle tue mani…":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto2[7]])
				
			"Non fai tu le regole,\n sbrigati che il tempo scorre":
				Global.modify_fine_atto2_rapitore()
				if(Global.fine_atto2_carlo == true && Global.fine_atto2_rapitore == true):
					Global.modify_fine_atto2()
					Global.chat_completed = true
					if(Global.already_notified_rapitore == false):
						$NotificaDiario.show_notify_diario()
						Global.yes_already_notified_rapitore()
						Global.save_progress_data()
				if(Global.chiamata_1_finita):
					yield(get_tree().create_timer(2),"timeout")
					add_received_message(Global.chat_rapitore_to_jimmy_atto3[0])
					yield(get_tree().create_timer(2),"timeout")
					create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[0],Global.chat_jimmy_to_rapitore_atto3[1]])
	if(Global.chiamata_1_finita):
		match question:
			"Tic Tac il tempo sta per scadere,\n hai preso tutti i soldi?":
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[0],Global.chat_jimmy_to_rapitore_atto3[1]])
			"res://fotoAlessia/foto_n2_chat.jpg":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[1])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[2])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[2]])
			"Contento? questo è l’ultimo desiderio\n che ti lascio esprimere":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_rapitore_to_jimmy_atto3[2])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[2]])
			"Ora, tra circa 20 minuti\n il mio contatto sarà da te":
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[2]])
			"Riempi un borsone e lascialo sotto casa\n esattamente quando te lo dico io":
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[3]])
				if(Global.chat_tictac == true):
					yield(get_tree().create_timer(2),"timeout")
					add_received_message(Global.chat_rapitore_to_jimmy_atto3[4])
					yield(get_tree().create_timer(2),"timeout")
					create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[4]])
	if(Global.chat_tictac == true):
		match question:
			"tic tac… tic tac…. tic tac…":
				if(Global.chat_10minuti == true):
					yield(get_tree().create_timer(2),"timeout")
					add_received_message(Global.chat_rapitore_to_jimmy_atto3[5])
					yield(get_tree().create_timer(2),"timeout")
					create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[5]])
			
	if(Global.chat_trillo_esca == true):
		match question:
			"Non fai tu le regole,\n sbrigati che il tempo scorre":
				create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto3[7]])
		
func add_received_image(image_path):
	var found = false
	var bubble = ReceivedImageBubble.instance()
	var texture = load(image_path)
	var texture_rect = bubble.get_node("VBoxContainer/TextureRect")
	texture_rect.texture = texture

	if texture:
		texture_rect.rect_min_size = Vector2(texture.get_width(), texture.get_height())
		texture_rect.rect_size = Vector2(texture.get_width(), texture.get_height())

	bubble.get_node("VBoxContainer").margin_left = 30
	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGN_BEGIN 

	var message_container_left = VBoxContainer.new()
	message_container_left.add_child(bubble)
	var spacer_right = Control.new()
	spacer_right.rect_min_size = Vector2(0, 70)
	spacer_right.set_h_size_flags(Control.SIZE_EXPAND_FILL)

	hbox.add_child(message_container_left)
	hbox.add_child(spacer_right)
	message_container.add_child(hbox)

	create_spacer()

	yield(get_tree().create_timer(0.3),"timeout")
	scroll_to_bottom()
	if(Global.chat_messages_rapitore != []):
		for message in Global.chat_messages_rapitore:
			if image_path in message["text"]:
				found = true
				break
		if(!found):
			Global.add_message_rapitore({"type": "received_image", "text": image_path})
	else:
		Global.add_message_rapitore({"type": "received_image", "text": image_path})

