extends TextureRect

@export var dialogue_key: String
@export var text_speed: float = 0.03

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
		if dialogue_key == "0":
			var bombTimer = load("res://Scenes/BombTimer/bombTimer.tscn").instantiate()
			get_node("/root/Room").add_child(bombTimer)
		elif dialogue_key == "5":
			get_node("/root/Room/InventoryShowArea2D/Inventory").set_items("Water")
		elif dialogue_key == "10":
			global.ending = 0
			get_tree().change_scene_to_file("res://Scenes/Endscreen/endscreen.tscn")
		elif dialogue_key == "18":
			global.ending = 2
			get_node("/root/Room/DialogueHandler/Luke").set_is_alive(false)
		elif dialogue_key == "20":
			global.ending = 2
			get_node("/root/Room/DialogueHandler/Willie").set_is_alive(false)
		elif dialogue_key == "9" or dialogue_key == "8":
			global.ending = 2
			get_tree().change_scene_to_file("res://Scenes/Endscreen/endscreen.tscn")
		queue_free()
	else:
		var str_num = str(phrase_num)
		$Name.bbcode_text = text_dialogue[str_num]["Name"]
		$Text.bbcode_text = text_dialogue[str_num]["Text"]
		$Text.visible_characters = 0
		$SpeakerSprite.play(text_dialogue[str_num]["Name"] + "_" + text_dialogue[str_num]["Emotion"])
		finished = false
		var playedA = false
		while $Text.visible_characters < len($Text.text):
			$Text.visible_characters += 1
			if playedA:
				$letterAppearB.play()
			else:
				$letterAppear.play()
			playedA = !playedA
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
