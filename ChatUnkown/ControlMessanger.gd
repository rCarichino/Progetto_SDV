extends Control


var MessaggioRicevuto = preload("res://bubbleRicevuto/Speech.tscn")
var MessaggioInviato  = preload("res://bubbleInvio/Speech.tscn")
var ReceivedImageBubble = preload("res://bubbleImmagine/ImageBubble.tscn")  # Carica la nuova scena


onready var scroll_container = $HBoxContainer/ChatContainer/ScrollContainer
onready var message_container = $HBoxContainer/ChatContainer/ScrollContainer/VBoxContainer

func _ready():
	if(Global.fine_prologo == true):
		$HBoxContainer/ChatListContainer/ItemList.add_item("User_454234",preload("res://icone/imgRapitore64.png"))
	
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
		"? k 6???? Cm sai k é Alessia":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[1])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[1],Global.chat_jimmy_to_rapitore_atto1[2]])
			
		"nn intendo cadere in 1 di qst truffe online":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[2])
			yield(get_tree().create_timer(2),"timeout")
			add_received_image("res://fotoAlessia/foto_n1_chat.jpg")
			yield(get_tree().create_timer(3),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[3])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
		"In k senso?":
			yield(get_tree().create_timer(1),"timeout")
			add_received_image("res://fotoAlessia/foto_n1_chat.jpg")
			yield(get_tree().create_timer(3),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[3])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
			
		"Va bene come vuoi tu, non farle del male perfavore":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[4])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])

		"Ok ma cosa vuoi da noi":
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[5])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])

		"[Chiama la polizia]":
			###inserire un finale
			Global.modify_fine_atto1()

		"[Chiama Alessia]":
			##far partire uno squillo
			yield(get_tree().create_timer(2),"timeout")
			add_received_message(Global.chat_rapitore_to_jimmy_atto1[6])
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])
			
		"Va bene…":
			Global.modify_fine_atto1()

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
	if(Global.chat_messages_rapitore[length-1].type == "received"):
		question = Global.chat_messages_rapitore[length-1].text
		load_answer(question)
	elif(Global.chat_messages_rapitore[length-1].type == "sent"):
		question = Global.chat_messages_rapitore[length-1].text
		give_answer(question)
	

func load_answer(question):
	print(question)
	match question:
		"Beh, effettivamente come potresti saperlo! É qui con me":
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[1],Global.chat_jimmy_to_rapitore_atto1[2]])
		"Pensi che ti stia prendendo per il culo?":
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[3],Global.chat_jimmy_to_rapitore_atto1[4],
			Global.chat_jimmy_to_rapitore_atto1[5],Global.chat_jimmy_to_rapitore_atto1[6]])
		"Se ascolterai tutto quello che ti dico, forse non le accadrá nulla", \
		"Lo scoprirai molto presto, per ora ascolta tutto quello che ti dico",\
		"Inutile che provi a chiamare":
			create_phrase_buttons([Global.chat_jimmy_to_rapitore_atto1[7]])

func add_received_image(image_path):
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
	
	Global.add_message_rapitore({"type": "received_image", "text": image_path})