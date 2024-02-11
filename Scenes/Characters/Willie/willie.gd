extends Node2D


signal dialogue(pathToDialogue: String)

func _on_clickable_area_area_clicked():
	get_parent().get_parent().get_node("InventoryShowArea2D").get_child(1).get_items()
	
	dialogue.emit("")
