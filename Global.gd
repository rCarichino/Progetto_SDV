extends Node

var chiamata_1_finita = false   #carlo chiede la foto

var chat_1_finita = false    #jimmy ottiene la foto

var already_started = false 
var fine_seconda_chiamata = false 
var tictac_displayed = false
var chat10_displayed = false
var chat5_displayed = false



var chat_tictac = false
var chat_10minuti = false
var chat_5minuti = false
var chat_trillo_esca = false

var timer_expired = false

var step = 0

#servono alla gestione dei dialoghi fade in
var chat_completed = false  #se vero, puo far partire la chiamata col numero corrente

var stato_chiamata = 1  #indica quale timeline di chiamata attivare

var residence_as_first = false   #se si è scelto il residence come prima opzione, allora è vera

var trillo = false

var trillo_unloked_rapitore = false

var already_notified_carlo = false

var already_notified_rapitore = false

var sblocco_atto2_rapitore = false 

var sblocco_atto2_carlo = false 

var fine_prologo = false 

var fine_atto1 = false

var fine_atto2_carlo = false 

var fine_atto2_rapitore = false 

var fine_atto2 = false 

var fine_gioco = false 

var foto1 = false 

var foto2 = false 

var setnotifica = false 

var setnotificaDiario = false 

var mappa = ""

var chat_messages_carlo = [] 

var chat_messages_rapitore = [] 

func add_message_carlo(message):
	chat_messages_carlo.append(message)

func get_messages_carlo():
	return chat_messages_carlo

func add_message_rapitore(message):
	chat_messages_rapitore.append(message)

func get_messages_rapitore():
	return chat_messages_rapitore

func modify_trillo():
	trillo = true

func get_trillo():
	return trillo

func yes_already_notified_carlo():
	already_notified_carlo = true

func not_already_notified_carlo():
	already_notified_carlo = false
	
func get_already_notified_carlo():
	return already_notified_carlo

func yes_already_notified_rapitore():
	already_notified_rapitore = true
	
func not_already_notified_rapitore():
	already_notified_rapitore = false

func get_already_notified_rapitore():
	return already_notified_rapitore


func modify_sblocco_atto2_rapitore():
	sblocco_atto2_rapitore = true

func get_sblocco_atto2_rapitore():
	return sblocco_atto2_rapitore

func modify_sblocco_atto2_carlo():
	sblocco_atto2_carlo = true

func get_sblocco_atto2_carlo():
	return sblocco_atto2_carlo

func modify_fine_prologo():
	fine_prologo = true

func get_fine_prologo():
	return fine_prologo

func modify_fine_atto1():
	fine_atto1 = true

func get_fine_atto1():
	return fine_atto1

func modify_fine_atto2_carlo():
	fine_atto2_carlo = true

func get_fine_atto2_carlo():
	return fine_atto2_carlo
	
func modify_fine_atto2_rapitore():
	fine_atto2_rapitore = true

func get_fine_atto2_rapitore():
	return fine_atto2_rapitore
	
func modify_fine_atto2():
	fine_atto2 = true

func get_fine_atto2():
	return fine_atto2

func modify_fine_gioco():
	fine_gioco = true

func get_fine_gioco():
	return fine_gioco

func modify_foto1():
	foto1 = true

func get_foto1():
	return foto1

func modify_foto2():
	foto2 = true

func get_foto2():
	return foto2

func switchcolonnasonoraSad():
	if(fine_prologo==true):
		Colonnasonorachill.switchcolonnaSad()

func switchcolonnasonorachill():
	Colonnasonorachill.switchcolonnachill()

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
	"Ehy Carlo!, tt bn!!\n Sì, l’ho comprato, tu?",
	"Mi sta piacendo un sacco",
	"Mi sa che lo riporto in negozio",
	"Ho finito adesso a lavoro, tu?",
	"nnt, tu?",
	"Me lo dovresti dire tu!\n so che sei uscito cn lei l’altra sera? xD",
	"Si è vista cn un ragazzo l’altro giorno,\n dovresti dirmelo tu? xD",
	"Secondo me la vedi + tu k io xD",
	"AH kk"
]

var chat_rapitore_to_jimmy_atto1 = [
	"Ciao Jimmy, come sta Alessia?",
	"Beh, effettivamente come potresti saperlo! É qui con me",
	"Pensi che ti stia prendendo per il culo?",
	"Non ti azzardare a contattare qualcuno",
	"Chiamare la polizia",
	"O a muoverti da quella cazzo di sedia",
	"Se non ho tue risposte entro 5 minuti",
	"Alessia raggiunge mamma e papà.",
	"E vedi di scrivere in modo decente…",
	"Se ascolterai tutto quello che ti dico\nforse non le accadrá nulla",
	"Lo scoprirai molto presto,\n per ora ascolta tutto quello che ti dico",
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
	"Va bene…"
]

var chat_carlo_to_jimmy_atto2 = [
	"Ue ho finito, vuoi giocare???",
	"k succ?",
	"[ARRIVA UN ALTRO TRILLO]",
	"Dai nn dire ste cazzate neanche x scherzo",
	"Cazzo dici, ma smettila",
	"Oh cazzo",
	"Sicuro sia lei?",
	"Cazzo hai ragione",
	"Chiama immediatamente la polizia",
	"CHIAMA LA POLIZIA",
	"BRUTTO COGLIONE CHIAMA LA POLIZIA",
	"Dimmi come vuoi che ti aiuti se posso",
	"In che senso non puoi muoverti?",
	"Quindi cosa vuoi che faccia?",
	"Eh e quale sarebbe il piano?",
	"Okok e come ci sentiamo?",
	"kk corro"
]

var chat_jimmy_to_carlo_atto2 = [
	"Guarda non é il momento",
	"[Ignora Carlo]",
	"Senti Carlo é successa una cosa grave...", 
	"Qualcuno mi ha contattato", 
	"E dice di aver rapito Ale, credo voglia dei soldi",
	"Fra ti giuro, non credo sia uno scherzo, ho paura…",
	"Adesso ci credi?",
	"Guarda il tatuaggio sul braccio…",
	"Non so cosa fare…",
	"Ho paura a chiamare la polizia,\n mi ha detto di non farlo",
	"[Chiama la polizia]",
	"Ho troppa paura…\n Non ce la faccio, ho paura che le faccia del male",
	"Fra, sei vestito",
	"Io non posso muovermi",
	"Devo continuare a rispondergli",
	"Fra dovrai essere le mie gambe,\ndevi andare tu al posto mio",
	"Ma quindi sei vestito?",
	"Non lo so mi verrá in mente dopo,\ntu esci di casa e vai in macchina",
	"Per ora vai in macchina",
	"Con il telefono deficiente",
]

var chat_rapitore_to_jimmy_atto2 = [
	"Adesso è arrivato il momento di dimostrare\n quanto ci tieni a tua sorella.",
	"Voglio 20 mila euro in contanti",
	"Dovrai lasciare i soldi vicino casa tua",
	"E alle ore 18.30 passerà un mio contatto a ritirarli.",
	"Non devi assolutamente avere niente\n a che fare con il contatto", 
	"Altrimenti succederà qualcosa a tua sorella",
	"Perchè mi stai mentendo?\n Non tieni abbastanza a tua sorella a quanto pare",
	"Non ti interessa",
	"Non credo tu abbia altra scelta",
	"Conosco benissimo la storia della tua famiglia,\n non trovare scuse",
	"Ricordati che la vita di tua sorella è nelle tue mani…",
	"Non fai tu le regole,\n sbrigati che il tempo scorre",
]

var chat_jimmy_to_rapitore_atto2 = [
	"Non ho tutti quei soldi",
	"Come fai a sapere dove abito?",
	"Come posso fidarmi di te?\n Dopo che ti avrò dato i soldi libererai mia sorella?",
	"Ti sto dicendo la verità, non ho tutti quei soldi",
	"In ogni caso non ho tutti quei soldi",
	"Non ho scelta ma non neanche tutti quei soldi",
	"Ok, dammi un po’ di tempo che trovo i soldi",
	"Io li cerco, ma tu non toccarla",
]

var chat_rapitore_to_jimmy_atto3 = [

	"Tic Tac il tempo sta per scadere,\n hai preso tutti i soldi?",
	"Contento? questo è l’ultimo desiderio\n che ti lascio esprimere",
	"Ora, tra circa 20 minuti\n il mio contatto sarà da te",
	"Riempi un borsone e lascialo sotto casa\n esattamente quando te lo dico io",
	"tic tac… tic tac…. tic tac…",
	"Mancano 10 minuti…",
	"Mancano 5 minuti…",
	"Non è un tuo problema,\n lo saprai quando serve",

]


var chat_jimmy_to_rapitore_atto3 = [

	"Ma mandami una sua foto ti prego,\nvoglio sapere se sta bene",
	"Mandami però una sua foto,\nvoglio capire se sta bene",
	"Va bene, cosa devo fare?",
	"Ok…",
	"Ho tutto quello che mi hai chiesto,\n adesso devo metterli insieme",
	"E’ tutto pronto, dammi un attimo",
	"E’ tutto pronto",
	"A che punto è il tuo contatto?"

]


var global_volumeCS: float = 0.4
var global_volumesfx: float = 0.4
var global_volumedialoghi: float = 0.4

func save_settings():
	var settings = SettingsData.new()
	settings.global_volumeCS = global_volumeCS
	settings.global_volumesfx = global_volumesfx
	settings.global_volumedialoghi = global_volumedialoghi
	
	var err = ResourceSaver.save("res://salvataggi/salvataggi_impostazioni/SettingsData.tres", settings)
	if err == OK:
		print("Settings saved successfully.")
	else:
		print("Error saving settings: ", err)

func load_settings():
	var settings = ResourceLoader.load("res://salvataggi/salvataggi_impostazioni/SettingsData.tres") as SettingsData
	if settings:
		global_volumeCS = settings.global_volumeCS
		global_volumesfx = settings.global_volumesfx
		global_volumedialoghi = settings.global_volumedialoghi
		print("Settings loaded successfully.")
	else:
		print("Error loading settings.")

# Salva i dati globali su un file JSON
func save_progress_data():
	var progress = ProgressData.new()
	progress.sblocco_atto2_rapitore = sblocco_atto2_rapitore
	progress.sblocco_atto2_carlo = sblocco_atto2_carlo
	progress.fine_prologo = fine_prologo
	progress.fine_atto1 = fine_atto1
	progress.fine_atto2_carlo = fine_atto2_carlo
	progress.fine_atto2_rapitore = fine_atto2_rapitore
	progress.fine_atto2 = fine_atto2
	progress.fine_gioco = fine_gioco
	progress.foto1 = foto1
	progress.foto2 = foto2
	progress.chat_messages_carlo = chat_messages_carlo
	progress.chat_messages_rapitore = chat_messages_rapitore
	
	var err = ResourceSaver.save("res://salvataggi/salvataggi_progressi/ProgressData.tres", progress)
	if err == OK:
		print("Progress saved successfully.")
	else:
		print("Error saving progress: ", err)
	
func load_progress_data():
	var progress = ResourceLoader.load("res://salvataggi/salvataggi_progressi/ProgressData.tres") as ProgressData
	if progress:
		sblocco_atto2_rapitore = progress.sblocco_atto2_rapitore
		sblocco_atto2_carlo = progress.sblocco_atto2_carlo
		fine_prologo = progress.fine_prologo
		fine_atto1 = progress.fine_atto1
		fine_atto2_carlo = progress.fine_atto2_carlo
		fine_atto2_rapitore = progress.fine_atto2_rapitore
		fine_atto2 = progress.fine_atto2
		fine_gioco = progress.fine_gioco
		foto1 = progress.foto1
		foto2 = progress.foto2
		chat_messages_carlo = progress.chat_messages_carlo
		chat_messages_rapitore = progress.chat_messages_rapitore


		
func fake_call_timer(time_sec):
	if(timer_expired == false):
		yield(get_tree().create_timer(time_sec),"timeout")
		timer_expired = true
		set_bus_volume(-25)
		DialogicLogic.seleziona_chiamata(stato_chiamata)
		get_tree().change_scene("res://Desktop/Node2D.tscn")
		

var original_volume = 0.0
var bus_name = "Colonna_Sonora"




func save_original_volume():
	var bus_index = AudioServer.get_bus_index(bus_name)
	original_volume = AudioServer.get_bus_volume_db(bus_index)


func set_bus_volume(volume_db: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, volume_db)
	var current_volume = AudioServer.get_bus_volume_db(bus_index)


func restore_volume():
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, original_volume)
	var restored_volume = AudioServer.get_bus_volume_db(bus_index)
