extends Control


var MessaggioRicevuto = preload("res://bubbleRicevuto/Speech.tscn")
var MessaggioInviato  = preload("res://bubbleInvio/Speech.tscn")


onready var scroll_container = $HBoxContainer/ChatContainer/ScrollContainer
onready var message_container = $HBoxContainer/ChatContainer/ScrollContainer/VBoxContainer


func _ready():
	if(Global.fine_prologo == true):
		$HBoxContainer/ChatListContainer/ItemList.add_item("User_454234",preload("res://icone/imgRapitore64.png"))
	
	create_spacer()
	load_messages()

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


func load_messages():
	# Carica i messaggi dal singleton
	for message in Global.chat_messages_alessia:
		if message["type"] == "sent":
			add_sent_message(message["text"])
		elif message["type"] == "received":
			add_received_message(message["text"])

func create_spacer():
	var spacer = Control.new()
	spacer.rect_min_size = Vector2(0, 50)  # Altezza minima dello spacer
	spacer.set_v_size_flags(Control.SIZE_EXPAND_FILL)
	message_container.add_child(spacer)
