extends VBoxContainer



func _on_ItemList_item_selected(index: int) -> void:

	match $ItemList.get_item_text(index):
		"xx_Ale":
			print($ItemList.get_item_text(index))
		"_CcCc_":
			print($ItemList.get_item_text(index))
			get_tree().change_scene("res://ChatCarlo/messanger.tscn")
		"Unknown":
			print($ItemList.get_item_text(index))
