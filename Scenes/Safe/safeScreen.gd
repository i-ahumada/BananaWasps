extends Control

signal safe_opened

func _on_leave_screen_pressed():
	get_tree().paused = false
	visible = false


func _on_display_show_key():
	for child in $frontColor.get_children():
		child.queue_free()
	
	safe_opened.emit()
	get_tree().paused = false
	queue_free()
