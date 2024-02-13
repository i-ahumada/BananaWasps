extends Node2D


signal dialogue(code: String)


func _on_clickable_area_area_clicked():
	dialogue.emit("1")
