extends Control


var MessaggioRicevuto = preload("res://bubbleRicevuto/Speech.tscn")
var MessaggioInviato  = preload("res://bubbleInvio/Speech.tscn")
var SendImageBubble = preload("res://bubbleImmagine/ImageBubble.tscn")  # Carica la nuova scena

onready var scroll_container = $HBoxContainer/ChatContainer/ScrollContainer
onready var message_container = $HBoxContainer/ChatContainer/ScrollContainer/VBoxContainer


func _ready():
	
	if(Global.fine_prologo == true):
		$HBoxContainer/ChatListContainer/ItemList.add_item("User_454234",preload("res://icone/imgRapitore64.png"))
	
	
	create_spacer()
	
	if(Global.chat_messages_carlo == []):
		add_received_message(Global.chat_carlo_to_jimmy_prologo[0])
		create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[0]])
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
	
	if(Global.chat_messages_carlo != []):
		for message in Global.chat_messages_carlo:
			if text in message["text"]:
				found = true
				break
		if(!found):
			Global.add_message_carlo({"type": "sent", "text": text})
	else:
		Global.add_message_carlo({"type": "sent", "text": text})


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
	
	if(Global.chat_messages_carlo != []):
		for message in Global.chat_messages_carlo:
			if text in message["text"]:
				found = true
				break
		if(!found):
			Global.add_message_carlo({"type": "received", "text": text})
	else:
		Global.add_message_carlo({"type": "received", "text": text})



func create_phrase_buttons(phrases):
	var vbox = $HBoxContainer/ChatContainer/HBoxContainer/VBoxContainer
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()

	for phrase in phrases:
		var button = Button.new()
		button.flat = true
		button.text = phrase
		
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
		button.connect("pressed", self, "_on_phrase_button_pressed", [button,phrase])
		vbox.add_child(button)



func _on_phrase_button_pressed(button,phrase):
	if(phrase == "Adesso ci credi?"):
		add_send_image("res://fotoAlessia/foto_n1_chat.jpg")
		add_sent_message(phrase)
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
		"Ehy Carlo!, tt bn!!\n Sì, l’ho comprato, tu?":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[1])
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[1],Global.chat_jimmy_to_carlo_prologo[2]])
		"Mi sta piacendo un sacco","Mi sa che lo riporto in negozio":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[2])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[3])
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[3],Global.chat_jimmy_to_carlo_prologo[4]])
		"Ho finito adesso a lavoro, tu?","nnt, tu?":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[4])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[5])
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[5],Global.chat_jimmy_to_carlo_prologo[6],Global.chat_jimmy_to_carlo_prologo[7]])
		"Me lo dovresti dire tu!\n so che sei uscito cn lei l’altra sera? xD",\
		"Si è vista cn un ragazzo l’altro giorno,\n dovresti dirmelo tu? xD",\
		"Secondo me la vedi + tu k io xD":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[7])
			yield(get_tree().create_timer(2),"timeout")
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[8]])
		"AH kk":
			Global.modify_fine_prologo()

			if(Global.fine_prologo == true):
				if($HBoxContainer/ChatListContainer/ItemList.get_item_text(2)  != "User_454234"):
					$HBoxContainer/ChatListContainer/ItemList.add_item("User_454234",preload("res://icone/imgRapitore64.png"))
					if(Global.already_notified_Carlo == false):
						$NotificaMSN.show_notify()
						$NotificaDiario.show_notify_diario()
						Global.yes_already_notified_Carlo()
						Global.save_progress_data()

			if(Global.fine_atto1 == true):
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[0])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[0],Global.chat_jimmy_to_carlo_atto2[1]])


	if(Global.fine_atto1 == true):
		match question: 
			"Guarda non é il momento":
				Global.not_already_notified_Carlo()
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[1])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[2]])
			"[Ignora Carlo]":
				Global.modify_trillo()
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[0]])

				if(Global.already_notified_carlo):
					$NotificaMSN.show_notify_diario()
					Global.yes_already_notified_carlo()
				
			"Senti Carlo é successa una cosa grave...":
				Global.not_already_notified_Carlo()
				yield(get_tree().create_timer(2),"timeout")
				add_sent_message(Global.chat_jimmy_to_carlo_atto2[3])
				yield(get_tree().create_timer(2),"timeout")
				add_sent_message(Global.chat_jimmy_to_carlo_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[3])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[5]])
				
			"Fra ti giuro, non credo sia uno scherzo, ho paura…":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[4])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[6]])
				
			"Adesso ci credi?":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[5])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[6])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[7]])
				
			"Guarda il tatuaggio sul braccio…":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[7])
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[8])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[8],Global.chat_jimmy_to_carlo_atto2[9]])
				
			"Non so cosa fare…":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[9])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[10]])
				
			"Ho paura a chiamare la polizia,\n mi ha detto di non farlo":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[10])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[11]])
				
			"[Chiama la polizia]":
				var finalePolizia = Dialogic.start('finale polizia')
				add_child(finalePolizia)
				
			"Ho troppa paura…\nNon ce la faccio, ho paura che le faccia del male":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[11])
				Global.modify_sblocco_atto2_rapitore()


				
				
	if(Global.sblocco_atto2_carlo == true):
		match question: 
			"Fra, sei vestito","Io non posso muovermi":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[12])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[12]])
				
			"Devo continuare a rispondergli":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[13])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[13]])
				
			"Fra dovrai essere le mie gambe,\n devi andare tu al posto mio":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[14])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[15],Global.chat_jimmy_to_carlo_atto2[16]])
				
			"Non lo so mi verrá in mente dopo,\n tu esci di casa e vai in macchina","Per ora vai in macchina":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[15])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[17]])
				
			"Con il telefono deficiente":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[16])
				Global.modify_fine_atto2_carlo()
				if(Global.fine_atto2_carlo && Global.fine_atto2_rapitore):
					Global.modify_fine_atto2()

				if(Global.already_notified_carlo == false):
					$NotificaDiario.show_notify_diario()
					Global.yes_already_notified_carlo()
					Global.save_progress_data()
				
			



func load_messages():
	# Carica i messaggi dal singleton
	for message in Global.get_messages_carlo():
		if message["type"] == "sent":
			add_sent_message(message["text"])
		elif message["type"] == "received":
			add_received_message(message["text"])
			


func create_spacer():
	var spacer = Control.new()
	spacer.rect_min_size = Vector2(0, 50)  # Altezza minima dello spacer
	spacer.set_v_size_flags(Control.SIZE_EXPAND_FILL)
	message_container.add_child(spacer)

func check_where_stopped():

	var length = Global.chat_messages_carlo.size()
	var question = ""
	if(Global.chat_messages_carlo[length-1].type == "received"):
		question = Global.chat_messages_carlo[length-1].text
		load_answer(question)
	elif(Global.chat_messages_carlo[length-1].type == "sent"):
		question = Global.chat_messages_carlo[length-1].text
		give_answer(question)



func load_answer(question):
	print(question)
	match question:
		"Ehy Jimmy, cm va? ma l’hai comprato\n alla fine il nuovo CoD":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[0]])
		"Sì anche io, prime impressioni?":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[1],Global.chat_jimmy_to_carlo_prologo[2]])
		"A me sta piacendo un sacco","K fai?":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[3],Global.chat_jimmy_to_carlo_prologo[4]])
		"Bro, nn faccio nulla tt il giorno cm sempre xD","Cmq, tua sorella cm sta? :P":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[5],Global.chat_jimmy_to_carlo_prologo[6],Global.chat_jimmy_to_carlo_prologo[7]])
		"??","nn ero io, cmq ora stacco e vado a mangiare":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[8]])
			
	if(Global.fine_atto1 == true):
		match question: 
			"Ue ho finito, vuoi giocare???":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[0],Global.chat_jimmy_to_carlo_atto2[1]])
			"k succ?":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[2]])
			"Dai nn dire ste cazzate neanche x scherzo":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[3]])
			"Cazzo dici, ma smettila":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[4]])
			"Oh cazzo":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[6])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[5]])
			"Sicuro sia lei?":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[5]])
			"Cazzo hai ragione":
				yield(get_tree().create_timer(2),"timeout")
				add_received_message(Global.chat_carlo_to_jimmy_atto2[8])
				yield(get_tree().create_timer(2),"timeout")
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[6],Global.chat_jimmy_to_carlo_atto2[7]])
			"Chiama immediatamente la polizia":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[6],Global.chat_jimmy_to_carlo_atto2[7]])
			"CHIAMA LA POLIZIA":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[8],Global.chat_jimmy_to_carlo_atto2[9]])
			"BRUTTO COGLIONE CHIAMA LA POLIZIA":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[8],Global.chat_jimmy_to_carlo_atto2[9]])

	if(Global.sblocco_atto2_carlo == true):
		match question:
			"Dimmi come vuoi che ti aiuti se posso":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[11]])
			"In che senso non puoi muoverti?":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[12]])
			"Quindi cosa vuoi che faccia?":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[13]])
			"Eh e quale sarebbe il piano?":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[15],Global.chat_jimmy_to_carlo_atto2[16]])
			"Okok e come ci sentiamo?":
				create_phrase_buttons([Global.chat_jimmy_to_carlo_atto2[17]])
			


func add_send_image(image_path):
	var found = false
	var bubble = SendImageBubble.instance()
	var texture = load(image_path)
	var texture_rect = bubble.get_node("VBoxContainer/TextureRect")
	texture_rect.texture = texture
	
	if texture:
		texture_rect.rect_min_size = Vector2(texture.get_width(), texture.get_height())
		texture_rect.rect_size = Vector2(texture.get_width(), texture.get_height())


	bubble.get_node("VBoxContainer").margin_left = -200

	var hbox = HBoxContainer.new()
	hbox.alignment = BoxContainer.ALIGN_END  
	
	var spacer_left = Control.new()
	spacer_left.rect_min_size = Vector2(0, 80)
	spacer_left.set_h_size_flags(Control.SIZE_EXPAND_FILL)
	
	var message_container_right = VBoxContainer.new()
	message_container_right.add_child(bubble)
	hbox.add_child(spacer_left)
	hbox.add_child(message_container_right)
	message_container.add_child(hbox)
	yield(get_tree().create_timer(0.3),"timeout")
	scroll_to_bottom()
	
	if(Global.chat_messages_carlo != []):
		for message in Global.chat_messages_rapitore:
			if image_path in message["text"]:
				found = true
				break
		if(!found):
			Global.add_message_carlo({"type": "received_image", "text": image_path})
	else:
		Global.add_message_carlo({"type": "received_image", "text": image_path})
