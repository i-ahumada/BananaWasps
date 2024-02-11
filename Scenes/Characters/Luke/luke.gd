extends Node2D


signal dialogue(text: String)


func _on_clickable_area_area_clicked():
	dialogue.emit("lukePresentation")
