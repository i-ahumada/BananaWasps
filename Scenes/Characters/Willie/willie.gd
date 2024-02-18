extends Node2D

@export var is_alive = true: get = get_is_alive, set = set_is_alive

signal dialogue(code: String)


func set_is_alive(val: bool):
	is_alive = val
	$ClickableArea/ClickZone.disabled = true
	$ClickableArea/Sprite2D.texture = load("res://Sprites/Characters/Grave.png")
	position.y = 520


func get_is_alive():
	return is_alive


func _on_clickable_area_area_clicked():
	if (!get_parent().get_node("Luke").get_is_alive()):
		dialogue.emit("9")
		set_is_alive(false)
	else:
		dialogue.emit("11")
