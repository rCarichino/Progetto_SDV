extends Control

# Funzione per inviare un messaggio
func _on_SendButton_pressed():
	var message = $LineEdit.text
	if message != "":
		Global.add_message(message)
		_add_message_to_chat(message)
		$LineEdit.text = ""

# Funzione per aggiungere un messaggio alla visualizzazione della chat
func _add_message_to_chat(message):
	var label = Label.new()
	label.text = message
	$ChatContainer.add_child(label)

# Carica i messaggi esistenti quando la scena è pronta
func _ready():
	for message in Global.get_messages():
		_add_message_to_chat(message)
