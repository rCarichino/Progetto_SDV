extends Control


var MessaggioRicevuto = preload("res://bubbleRicevuto/Speech.tscn")
var MessaggioInviato  = preload("res://bubbleInvio/Speech.tscn")

var phrases = ["Ehy Carlo!, tt bn!! Sì, l’ho comprato, tu?", "Mi sta piacendo un sacco", "Mi sa che lo riporto in negozio"]

onready var scroll_container = $HBoxContainer/ChatContainer/ScrollContainer
onready var message_container = $HBoxContainer/ChatContainer/ScrollContainer/VBoxContainer


func _ready():
	load_messages()
	create_phrase_buttons()



func scroll_to_bottom():
	scroll_container.scroll_vertical = scroll_container.get_v_scrollbar().max_value

func add_sent_message(text):
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
	Global.add_message({"type": "sent", "text": text})
	

func add_received_message(text):
	
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
	yield(get_tree().create_timer(1),"timeout")
	scroll_to_bottom()
	Global.add_message({"type": "received", "text": text})


func create_phrase_buttons():
	var hbox = $HBoxContainer/ChatContainer/HBoxContainer/VBoxContainer
	for phrase in phrases:
		var button = Button.new()
		button.text = phrase
		button.connect("pressed", self, "_on_phrase_button_pressed", [phrase])
		hbox.add_child(button)

func _on_phrase_button_pressed(phrase):
	add_sent_message(phrase)
	give_answer(phrase)

func give_answer(question):
	match question:
		"Ehy Carlo!, tt bn!! Sì, l’ho comprato, tu?":
			yield(get_tree().create_timer(5),"timeout")
			add_received_message(Global.answerCarlo[0])
		"Mi sta piacendo un sacco","Mi sa che lo riporto in negozio":
			yield(get_tree().create_timer(5),"timeout")
			add_received_message(Global.answerCarlo[1])

func load_messages():
	# Carica i messaggi dal singleton
	for message in Global.get_messages():
		if message["type"] == "sent":
			add_sent_message(message["text"])
		elif message["type"] == "received":
			add_received_message(message["text"])
