extends ColorRect

signal show_key

const MAX_LETTERS = 5
const PASSWORD = "SUSAN"
const GREEN = Color(0,1,0,1)
const RED = Color(1,0,0,1)
const WHITE = Color(1,1,1,1)

var letter_labels
var amount_letters_displayed = 0
var displayed_text = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	letter_labels = $HBoxContainer.get_children()
	for hbox in get_parent().get_node("VBoxContainer").get_children():
		for button in hbox.get_children():
			button.connect("send_leter", handle_letters)


func handle_letters(letter: String):
	if letter != "<" and letter != "Ok" and MAX_LETTERS != amount_letters_displayed:
		amount_letters_displayed += 1
		letter_labels[amount_letters_displayed - 1].text = letter
		displayed_text += letter
	elif letter == "<" and amount_letters_displayed > 0:
		letter_labels[amount_letters_displayed - 1].text = "_"
		displayed_text = displayed_text.substr(0, displayed_text.length() - 1)
		print(displayed_text)
		amount_letters_displayed -= 1
	elif letter == "Ok":
		if (PASSWORD == displayed_text):
			await blink_color(GREEN)
			show_key.emit()
		else:
			blink_color(RED)

func blink_color(color_blink: Color):
	for i in range(3):
		for label in letter_labels:
			label.set("theme_override_colors/font_color", color_blink)
		$BlinkTimer.start()
		await $BlinkTimer.timeout
		for label in letter_labels:
			label.set("theme_override_colors/font_color", WHITE)
		$BlinkTimer.start()
		await $BlinkTimer.timeout
		
		
