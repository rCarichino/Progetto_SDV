extends VBoxContainer



func _on_ItemList_item_selected(index: int) -> void:

	match $ItemList.get_item_text(index):
		"xx_Ale":
			print($ItemList.get_item_text(index))
			get_tree().change_scene("res://ChatAlessia/messanger.tscn")
		"_CcCc_":
			print($ItemList.get_item_text(index))
		"Unknown":
			print($ItemList.get_item_text(index))
