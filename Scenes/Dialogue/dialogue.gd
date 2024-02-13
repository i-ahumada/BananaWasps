extends Control

@export var decision_scene: PackedScene
@export var text_scene: PackedScene

const position_dialogues = Vector2(176, 460)

var text_code: String

func text_dialogue(dialogue_code: String):
	if (dialogue_code != "-1"):
		var text_instance = text_scene.instantiate()
		text_instance.dialogue_key = dialogue_code
		text_instance.connect("finished_text", decision_dialogue)
		text_instance.position = position_dialogues
		add_child(text_instance)


func decision_dialogue(dialogue_code: String):
	if (dialogue_code != "-1"):
		var decision_instance = decision_scene.instantiate()
		decision_instance.decision_code = dialogue_code
		decision_instance.connect("finished_decision", text_dialogue)
		decision_instance.position = position_dialogues
		add_child(decision_instance)


func _on_dialogue_handler_dialogue_sender(code):
	text_code = code
	text_dialogue(text_code)
