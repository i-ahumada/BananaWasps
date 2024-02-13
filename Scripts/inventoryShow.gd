extends Area2D

var mouse_inside = false 


func _on_mouse_entered():
	position.y += 110


func _on_mouse_exited():
	position.y -= 110
