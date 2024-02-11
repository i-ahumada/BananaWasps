extends ColorRect

@export var dialogueKey: String
@export var speakerSpritePath: String
@export var textSpeed: float = 0.05

const spritesRoot = "res://Sprites/Dialogue/"
const dialoguesRoot = "res://Text/conv"
var dialogue
var phraseNum = 0
var finished = false

# Called when the dialogue is of type text
func handle_text():
	if phraseNum >= len(dialogue):
		queue_free()
	else:
		var strNum = str(phraseNum)
		$Name.bbcode_text = dialogue[strNum]["Name"]
		$Text.bbcode_text = dialogue[strNum]["Text"]
		$Text.visible_characters = 0
		$SpeakerSprite.texture = load(spritesRoot + dialogue[strNum]["Name"] + "_" + dialogue[strNum]["Emotion"])
		finished = false

		while $Text.visible_characters < len($Text.text):
			$Text.visible_characters += 1
			
			$TimerDialogue.start()
			await $TimerDialogue.timeout
		
		finished = true
		phraseNum += 1

# Called when the dialogue is of type decision
func handle_decision():
	pass

# Runs Decision or Text
func next_phrase() -> void:
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerDialogue.wait_time = textSpeed
	dialogue = getDialog()
	assert(dialogue, "Dialogue not found.")
	next_phrase()
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			next_phrase()
		else:
			$Texto.visible_characters = len($Texto.text)


func getDialog() -> Dictionary:
	if !FileAccess.file_exists(dialoguesRoot + dialogueKey):
		return {}
	var f = FileAccess.open(dialoguesRoot + dialogueKey, FileAccess.READ)
	
	var jsonInfo = JSON.new()
	var dialogInfo = jsonInfo.parse_string(f.get_as_text())

	if typeof(dialogInfo) == TYPE_DICTIONARY:
		return dialogInfo
	else:
		return {}



