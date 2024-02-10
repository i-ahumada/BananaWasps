extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	for dialogue_sender in get_children():
		dialogue_sender.connect("dialogue", _on_dialogue, 0)

func _on_dialogue(text: String):
	print(text + " has spoken.")
