extends Area2D


var mouse_inside = false
signal area_clicked

func _on_mouse_entered():
	mouse_inside = true
	modulate = Color(0.5,0.5,0.5,1.0)


func _on_mouse_exited():
	mouse_inside = false
	modulate = Color(1.0,1.0,1.0,1.0)


func _input(event):
	if mouse_inside:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			area_clicked.emit()
