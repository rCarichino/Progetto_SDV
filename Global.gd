extends Node

var chat_completed = true

var stato_chiamata = 1

var unknown_unloked = false

var chat_messages = []

func add_message(message):
	chat_messages.append(message)

func get_messages():
	return chat_messages

func modify_unknown():
	unknown_unloked = !unknown_unloked

func get_unknowed():
	return unknown_unloked

var answerCarlo = [
	"Ehy Jimmy, cm va? ma l’hai comprato\n alla fine il nuovo CoD",
	"Sì anche io, prime impressioni?",
	"A me sta piacendo un sacco",
	"K fai?",
	"Bro, nn faccio nulla tt il giorno cm sempre xD",
	"Cmq, tua sorella cm sta? :P",
	"??",
	"nn ero io, cmq ora stacco e vado a mangiare"
]

var global_volumeCS: float = 0.4
var global_volumesfx: float = 0.4
var global_volumedialoghi: float = 0.4
