extends Control

# Chiave API di Google Gemini (sostituiscila con la tua)
var api_key = "AIzaSyDqQySQL25eKGVo8s3TPxrBSGQHEddivV4"

# URL dell'API di Google Gemini
var api_url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-latest:generateContent?key=" + api_key

# Riferimenti ai nodi dell'interfaccia
onready var chat_display = $ChatDisplay
onready var user_input = $UserInput
onready var send_button = $SendButton
onready var http_request = $HTTPRequest

# Lista dei messaggi per aggiornare il testo senza cancellare la chat
var messages = []  # Memorizza i messaggi per sostituire "Scrivendo..."
var placeholder_index = -1  # Salva l'indice del placeholder

# Inizializzazione
func _ready():
	send_button.connect("pressed", self, "_on_send_button_pressed")
	user_input.connect("text_entered", self, "_on_enter_pressed")
	http_request.connect("request_completed", self, "_on_request_completed")

# Invio con Enter
func _on_enter_pressed(_new_text):
	_on_send_button_pressed()

# Invio del messaggio
func _on_send_button_pressed():
	var user_message = user_input.text.strip_edges()
	if user_message != "":
		append_message("Utente", user_message, true)
		
		# Salva l'indice del placeholder
		placeholder_index = messages.size()
		append_message("AI", "Scrivendo...", false)

		send_message_to_gemini(user_message)
		user_input.text = ""

# Aggiunge il messaggio nella chat e lo salva nella lista
func append_message(sender: String, message: String, is_user: bool):
	var text_color = "[color=#3498DB]" if is_user else "[color=#2ECC71]"  # Blu per utente, verde per AI
	var formatted_message = text_color + "[b]" + sender + ":[/b] " + message + "[/color]"
	
	if is_user:
		formatted_message = "[right]" + formatted_message + "[/right]\n\n"
	else:
		formatted_message = formatted_message + "\n\n"

	# Aggiunge il messaggio alla lista e aggiorna la chat
	messages.append(formatted_message)
	update_chat_display()

# Sostituisce il placeholder "Scrivendo..." con la risposta AI
func replace_placeholder(new_text: String):
	if placeholder_index != -1 and placeholder_index < messages.size():
		messages[placeholder_index] = "[color=#2ECC71][b]AI:[/b] " + new_text + "[/color]\n\n"
		update_chat_display()
		placeholder_index = -1  # Reset dell'indice

# Aggiorna il contenuto della chat senza cancellare i messaggi precedenti
func update_chat_display():
	chat_display.bbcode_text = ""  # Cancella il testo corrente
	for msg in messages:
		chat_display.append_bbcode(msg + "\n")

# Invia il messaggio all'API di Google Gemini
func send_message_to_gemini(message: String):
	var headers = ["Content-Type: application/json"]
	var data = {
		"contents": [
			{
				"role": "user",
				"parts": [
					{"text": message}
				]
			}
		]
	}
	var json_data = JSON.print(data)
	http_request.request(api_url, headers, true, HTTPClient.METHOD_POST, json_data)

# Gestisce la risposta dell'API di Google Gemini
func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var response = JSON.parse(body.get_string_from_utf8())
		if response.error == OK:
			var reply = response.result["candidates"][0]["content"]["parts"][0]["text"].strip_edges()
			
			# Sostituisce il placeholder con la risposta AI
			replace_placeholder(reply)
		else:
			replace_placeholder("Errore nella risposta JSON")
	else:
		replace_placeholder("Errore nella richiesta HTTP: %s" % response_code)
