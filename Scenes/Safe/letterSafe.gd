extends Button

signal send_leter(letter: String)

func _ready():
	connect("pressed", handle_pressed)

func handle_pressed():
	send_leter.emit(text)
