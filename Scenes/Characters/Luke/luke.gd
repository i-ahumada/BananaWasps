extends Node2D


signal dialogue(code: String)

func _ready():
	var timer = get_tree().create_timer(0.05)
	await timer.timeout
	dialogue.emit("0")

func _on_clickable_area_area_clicked():
	dialogue.emit("1")
