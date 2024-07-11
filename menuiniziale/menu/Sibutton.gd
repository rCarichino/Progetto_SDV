extends Button

var dir = "res://salvataggi/salvataggi_impostazioni/global_data.json"

func nuova_p():
	var file = File.new()
	if file.file_exists(dir):
		file.file.remove("res://salvataggi/salvataggi_impostazioni/global_data.json")
		Global.chat_completed = false		#se vero, puo far partire la chiamata col numero corrente
		Global.stato_chiamata = 1			#indica quale timeline di chiamata attivare
		Global.residence_as_first = false	#se si è scelto il residence come prima opzione, allora è vera
		Global.trillo = false
		Global.sblocco_atto2_rapitore = false #AGGIUNGERE AL SAVE
		Global.sblocco_atto2_carlo = false #AGGIUNGERE AL SAVE
		Global.fine_prologo = false #SAVE
		Global.fine_atto1 = false #SAVE
		Global.fine_atto2_carlo = false #AGGIUNGERE AL SAVE
		Global.fine_atto2_rapitore = false #AGGIUNGERE AL SAVE
		Global.fine_atto2 = false #SAVE
		Global.fine_gioco = false #SAVE
		Global.foto1 = false #AGGIUNGERE AL SAVE
		Global.foto2 = false #AGGIUNGERE AL SAVE
		Global.setnotifica = false #serve a gestire l'arrivo dei messaggi
		Global.setnotificaDiario = false #serve per gestire la notifica del diario
		Global.chat_messages_carlo = [] #SAVE
		Global.chat_messages_rapitore = [] #SAVE


func _on_Sibutton_pressed():
	nuova_p()
	get_tree().change_scene("res://Desktop/Node2D.tscn")
