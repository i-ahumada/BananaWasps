extends Button


@export var text_code: String

signal decision_finished(text_code: String)

func _on_pressed():
	decision_finished.emit(text_code)
