extends VBoxContainer



func _on_ItemList_item_selected(index: int) -> void:

	match $ItemList.get_item_text(index):
		"xx_Ale":
			get_tree().change_scene("res://ChatAlessia/messanger.tscn")
		"_CcCc_":
			get_tree().change_scene("res://ChatCarlo/messanger.tscn")
		"User_454234":
			get_tree().change_scene("res://ChatUnkown/messanger.tscn")

