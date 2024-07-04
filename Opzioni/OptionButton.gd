extends OptionButton
func _ready():
	# Aggiungi le opzioni se non sono già state aggiunte tramite l'editor
	if get_item_count() == 0:
		add_item("Finestra")
		add_item("Schermo intero")
	
	# Collega il segnale "item_selected" a una funzione
	connect("item_selected", self, "_on_OptionButton_item_selected")
	
	# Imposta l'opzione iniziale in base allo stato corrente
	if OS.window_fullscreen:
		select(1)  # Se è in schermo intero, seleziona "Schermo intero"
	else:
		select(0)  # Se è in finestra, seleziona "Finestra"

func _on_OptionButton_item_selected(index):
	match index:
		0:
			OS.window_fullscreen = false  # Modalità finestra
			OS.window_maximized = false   # Assicurati che la finestra non sia massimizzata
		1:
			OS.window_fullscreen = true   # Modalità schermo intero


func _on_OptionButton_toggled(button_pressed):
	pass # Replace with function body.
