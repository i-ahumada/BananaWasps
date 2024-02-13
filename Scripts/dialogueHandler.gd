extends Node

signal dialogue_sender(code: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	for dialogue_node in get_children():
		dialogue_node.connect("dialogue", _on_dialogue, 0)

func _on_dialogue(code: String):
	dialogue_sender.emit(code)
	
