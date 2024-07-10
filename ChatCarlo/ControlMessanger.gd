extends Control


var MessaggioRicevuto = preload("res://bubbleRicevuto/Speech.tscn")
var MessaggioInviato  = preload("res://bubbleInvio/Speech.tscn")


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
		"Ehy Carlo!, tt bn!! Sì, l’ho comprato, tu?":
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
		"Me lo dovresti dire tu! so che sei uscito cn lei l’altra sera? xD",\
		"Si è vista cn un ragazzo l’altro giorno, dovresti dirmelo tu? xD",\
		"Secondo me la vedi + tu k io xD":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[6])
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_carlo_to_jimmy_prologo[7])
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[8]])
		"AH kk":
			Global.modify_fine_prologo()
			if(Global.fine_prologo == true):
				$HBoxContainer/ChatListContainer/ItemList.add_item("User_454234",preload("res://icone/imgRapitore64.png"))
			#DA METTERE IL SALVATAGGIO
		


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
		"Sì anche io, prime impressioni?":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[1],Global.chat_jimmy_to_carlo_prologo[2]])
		"A me sta piacendo un sacco","K fai?":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[3],Global.chat_jimmy_to_carlo_prologo[4]])
		"Bro, nn faccio nulla tt il giorno cm sempre xD","Cmq, tua sorella cm sta? :P":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[5],Global.chat_jimmy_to_carlo_prologo[6],Global.chat_jimmy_to_carlo_prologo[7]])
		"??","nn ero io, cmq ora stacco e vado a mangiare":
			create_phrase_buttons([Global.chat_jimmy_to_carlo_prologo[8]])

