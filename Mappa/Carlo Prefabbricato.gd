extends Sprite


func _on_dialogic_signal(argument:String):
	if argument == "prefabbricato":
		self.show()
