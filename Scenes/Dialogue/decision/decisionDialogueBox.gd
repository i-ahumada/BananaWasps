extends TextureRect


@export var button_scene: PackedScene
@export var decision_code: String

signal finished_decision(text_code: String)

const options_root = "res://Decisions/deci"

var options: Dictionary


func _render_options():
	var inventory = get_node("/root/Room/InventoryShowArea2D/Inventory").get_items()
	for option in options:
		var button_instance = button_scene.instantiate()
		if (inventory.has(options[option]["Restraint"]) or options[option]["Restraint"] == ""):
			button_instance.text_code = options[option]["Text_Code"]
			button_instance.text = options[option]["Text"]
		else:
			button_instance.disabled = true
		$VBoxContainer.add_child(button_instance)
	
	for buttons in $VBoxContainer.get_children():
		buttons.connect("decision_finished", _decision_finished, 0)


func _decision_finished(text_code: String):
	if text_code == "-1":
		get_tree().paused = false
	finished_decision.emit(text_code)
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	options = _get_options()
	assert(options, "Dialogue not found.")
	_render_options()

func _get_options() -> Dictionary:
	if !FileAccess.file_exists(options_root + decision_code + ".json"):
		return {}
	var f = FileAccess.open(options_root + decision_code + ".json", FileAccess.READ)
	
	var options_info = JSON.parse_string(f.get_as_text())
	
	if typeof(options_info) == TYPE_DICTIONARY:
		return options_info
	else:
		return {}
