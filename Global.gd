extends Node

var fine_prologo = false #SAVE

var fine_atto1 = false #SAVE

var fine_atto2 = false #SAVE

var fine_gioco = false #SAVE

var chat_messages_carlo = [] #SAVE

var chat_messages_rapitore = [] #SAVE

func add_message_carlo(message):
	chat_messages_carlo.append(message)

func get_messages_carlo():
	return chat_messages_carlo

func add_message_rapitore(message):
	chat_messages_rapitore.append(message)

func get_messages_rapitore():
	return chat_messages_rapitore

func modify_fine_prologo():
	fine_prologo = !fine_prologo

func get_fine_prologo():
	return fine_prologo

func modify_fine_atto1():
	fine_atto1 = !fine_atto1

func get_fine_atto1():
	return fine_atto1

func modify_fine_atto2():
	fine_atto2 = !fine_atto2

func get_fine_atto2():
	return fine_atto2

func modify_fine_gioco():
	fine_gioco = !fine_gioco

func get_fine_gioco():
	return fine_gioco


var chat_messages_alessia = [
	{"type": "received", "text": "fratello ma stasera 6 a casa?"},
	{"type": "sent", "text": "no, non ti ricordi"},
	{"type": "received", "text": "ah kk"},
	{"type": "received", "text": "io dv fare il turno stasera"},
	{"type": "received", "text": "mi lasci le chiavi?"},
	{"type": "sent", "text": "sisi tranq"},
	{"type": "sent", "text": "ti serve la macchina domani?"},
	{"type": "received", "text": "no passa Sofia a prendermi"},
	{"type": "sent", "text": "mi mandi un mex quando arrivi?"},
	{"type": "received", "text": "uff va bene"},
	{"type": "sent", "text": "abbassa la musica x la miseriaaaaa"},
	{"type": "received", "text": "ahahah xk?"},
	{"type": "sent", "text": "i tokio hotel nn mi aiutano a concentrarmi"},
	{"type": "received", "text": "k palle k 6!"},
	{"type": "sent", "text": "a k ora torni?"},
	{"type": "received", "text": "nn torno io sto fuori stase"},
	{"type": "sent", "text": "cn k?"},
	{"type": "received", "text": " un ragazzo lol"},
]


var chat_carlo_to_jimmy_prologo = [
	"Ehy Jimmy, cm va? ma l’hai comprato\n alla fine il nuovo CoD",
	"Sì anche io, prime impressioni?",
	"A me sta piacendo un sacco",
	"K fai?",
	"Bro, nn faccio nulla tt il giorno cm sempre xD",
	"Cmq, tua sorella cm sta? :P",
	"??",
	"nn ero io, cmq ora stacco e vado a mangiare"
]

var chat_jimmy_to_carlo_prologo = [
	"Ehy Carlo!, tt bn!! Sì, l’ho comprato, tu?",
	"Mi sta piacendo un sacco",
	"Mi sa che lo riporto in negozio",
	"Ho finito adesso a lavoro, tu?",
	"nnt, tu?",
	"Me lo dovresti dire tu! so che sei uscito cn lei l’altra sera? xD",
	"Si è vista cn un ragazzo l’altro giorno, dovresti dirmelo tu? xD",
	"Secondo me la vedi + tu k io xD",
	"AH kk"
]

var chat_rapitore_to_jimmy_atto1 = [
	"Ciao Jimmy, come sta Alessia?",
	"Beh, effettivamente come potresti saperlo! É qui con me",
	"Pensi che ti stia prendendo per il culo?",
	"Non ti azzardare a contattare qualcuno,chiamare la polizia/n o a muoverti da quella di sedia," + \
	"/nse non ho tue risposte entro 5 minuti Alessia raggiunge mamma e papà./n E vedi di scrivere in modo decente…",
	"Se ascolterai tutto quello che ti dico, forse non le accadrá nulla",
	"Lo scoprirai molto presto, per ora ascolta tutto quello che ti dico",
	"Inutile che provi a chiamare"
]

var chat_jimmy_to_rapitore_atto1 = [
	"? k 6???? Cm sai k é Alessia",
	"nn intendo cadere in 1 di qst truffe online",
	"In k senso?",
	"Va bene come vuoi tu, non farle del male perfavore",
	"Ok ma cosa vuoi da noi",
	"[Chiama la polizia]",
	"[Chiama Alessia]",
]


var global_volumeCS: float = 0.4
var global_volumesfx: float = 0.4
var global_volumedialoghi: float = 0.4

# Salva i dati globali su un file JSON
func save_global_data():
	var save_data = {
		"fine_prologo": fine_prologo,
		"fine_atto1": fine_atto1,
		"fine_atto2": fine_atto2,
		"fine_gioco": fine_gioco,
		"chat_messages_carlo": chat_messages_carlo,
		"chat_messages_rapitore": chat_messages_rapitore,
		"global_volumeCS": global_volumeCS,
		"global_volumesfx": global_volumesfx,
		"global_volumedialoghi": global_volumedialoghi
	}
	var file = File.new()
	file.open("res://salvataggi/salvataggi_impostazioni/global_data.json", File.WRITE)
	file.store_string(JSON.print(save_data))
	print("Salvataggio effettuato")
	file.close()
# Carica i dati globali da un gile JSON
func load_global_data():
	var file = File.new()
	if file.file_exists("res://salvataggi/salvataggi_impostazioni/global_data.json"):
		print("cristo")
		file.open("res://salvataggi/salvataggi_impostazioni/global_data.json", File.READ)
		var data = JSON.parse(file.get_as_text())
		print(data.error)
		file.close()
		if data.error == OK:
			var save_data = data.result
			fine_prologo = save_data.get("fine_prologo", false)
			fine_atto1 = save_data.get("fine_atto1", false)
			fine_atto2 = save_data.get("fine_atto2", false)
			fine_gioco = save_data.get("fine_gioco", false)
			chat_messages_carlo = save_data.get("chat_messages_carlo", [])
			chat_messages_rapitore = save_data.get("chat_messages_rapitore", [])
			global_volumeCS = save_data.get("global_volumeCS", 0.4)
			global_volumesfx = save_data.get("global_volumesfx", 0.4)
			global_volumedialoghi = save_data.get("global_volumedialoghi", 0.4)
			print(data.result)
			print(fine_prologo)
			print(fine_atto1)
			print(fine_atto2)
			print(fine_gioco)
			print(chat_messages_carlo)
			print(chat_messages_rapitore)
			print(global_volumeCS)
			print(global_volumesfx)
			print(global_volumedialoghi)
