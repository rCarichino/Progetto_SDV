extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.chiamata_1_finita == true:
		$LabelResidence.show()
		$LabelCampoSportivo.show()
		$LabelPrefabbricato.show()

	match Global.mappa:
		"Residence":
			$LabelResidence/CarloResidence.show()
			$LabelCampoSportivo/CarloCampoSportivo.hide()
			$LabelPrefabbricato/CarloPrefabbricato.hide()
			$CarloInizio.hide()
		"CampoSportivo":
			$LabelCampoSportivo/CarloCampoSportivo.show()
			$LabelResidence/CarloResidence.hide()
			$LabelPrefabbricato/CarloPrefabbricato.hide()
			$CarloInizio.hide()
		"Prefabbricato":
			$LabelPrefabbricato/CarloPrefabbricato.show()
			$LabelResidence/CarloResidence.hide()
			$LabelCampoSportivo/CarloCampoSportivo.hide()
			$CarloInizio.hide()
		
