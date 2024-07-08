extends HSlider

export var bus_name: String

var bus_index: int

func _ready() -> void:
	# Ottieni l'indice del bus usando il nome
	bus_index = AudioServer.get_bus_index(bus_name)
	
	# Controlla se l'indice è valido
	if bus_index == -1:
		print("Errore: Nome del bus non trovato.")
		return
	
	# Connetti il segnale del cambio di valore
	connect("value_changed", self, "_on_value_changed")
	
	# Imposta il valore del slider alla variabile globale del volume
	value = Global.global_volumesfx
	AudioServer.set_bus_volume_db(bus_index, linear2db(Global.global_volumesfx))



func _on_HSlider_value_changed(value):
	# Imposta il volume del bus quando il valore del slider cambia
	AudioServer.set_bus_volume_db(bus_index, linear2db(value))
	
	# Aggiorna la variabile globale del volume
	Global.global_volumesfx = value
