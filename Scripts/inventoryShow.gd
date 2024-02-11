extends Area2D

var mouse_inside = false 

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	position.y += 110


func _on_mouse_exited():
	position.y -= 110
