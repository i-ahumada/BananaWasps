extends TextureRect

@export var dialogue_key: String
@export var text_speed: float = 0.05

signal finished_text(decision_code: String)

const sprites_root = "res://Sprites/Dialogue/"
const dialogues_root = "res://Dialogue/conv"

var decision_code
var text_dialogue
var dialogue
var phrase_num = 0
var finished = false

# Runs Decision or Text
func next_phrase() -> void:
	if phrase_num >= len(text_dialogue):
		if decision_code != "-1":
			finished_text.emit(decision_code)
		else:
			get_tree().paused = false
		queue_free()
	else:
		var str_num = str(phrase_num)
		$Name.bbcode_text = text_dialogue[str_num]["Name"]
		$Text.bbcode_text = text_dialogue[str_num]["Text"]
		$Text.visible_characters = 0
		$SpeakerSprite.play(text_dialogue[str_num]["Name"] + "_" + text_dialogue[str_num]["Emotion"])
		finished = false

		while $Text.visible_characters < len($Text.text):
			$Text.visible_characters += 1
			
			$TimerDialogue.start(text_speed)
			await $TimerDialogue.timeout
		
		$SpeakerSprite.stop()
		finished = true
		phrase_num += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$TimerDialogue.wait_time = text_speed
	dialogue = getDialog()
	assert(dialogue, "Dialogue not found.")
	text_dialogue = dialogue["Text"]
	decision_code = dialogue["Decision"]
	next_phrase()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			next_phrase()
		else:
			$Text.visible_characters = len($Text.text)


func getDialog() -> Dictionary:
	if !FileAccess.file_exists(dialogues_root + dialogue_key + ".json"):
		return {}
	var f = FileAccess.open(dialogues_root + dialogue_key + ".json", FileAccess.READ)
	
	var dialog_info = JSON.parse_string(f.get_as_text())
	
	if typeof(dialog_info) == TYPE_DICTIONARY:
		return dialog_info
	else:
		return {}
