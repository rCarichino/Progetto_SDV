extends Button

var dir = "res://salvataggi/salvataggi_impostazioni/global_data.json"

func nuova_p():
	var file = File.new()
	if file.file_exists(dir):
		file.file.remove("res://salvataggi/salvataggi_impostazioni/global_data.json")
	Global.chiamata_1_finita = false
	Global.chat_1_finita = false 
	Global.chat_tictac = false
	Global.chat_10minuti = false
	Global.chat_5minuti = false
	Global.chat_trillo_esca = false
	Global.timer_expired = false
	Global.step = 0
	Global.chat_completed = false 
	Global.stato_chiamata = 1  
	Global.residence_as_first = false 
	Global.trillo = false
	Global.trillo_unloked_rapitore = false
	Global.already_notified_carlo = false
	Global.already_notified_rapitore = false
	Global.sblocco_atto2_rapitore = false 
	Global.sblocco_atto2_carlo = false 
	Global.fine_prologo = false 
	Global.fine_atto1 = false
	Global.fine_atto2_carlo = false 
	Global.fine_atto2_rapitore = false 
	Global.fine_atto2 = false 
	Global.fine_gioco = false 
	Global.foto1 = false 
	Global.foto2 = false 
	Global.setnotifica = false 
	Global.setnotificaDiario = false 
	Global.chat_messages_carlo = [] 
	Global.chat_messages_rapitore = [] 

func _on_Sibutton_pressed():
	nuova_p()
	get_tree().change_scene("res://Desktop/Node2D.tscn")
