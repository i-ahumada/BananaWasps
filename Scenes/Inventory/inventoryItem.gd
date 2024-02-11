extends MarginContainer

@export var sprite: Resource
@export var item_name: String

func _ready():
	$VBoxContainer/TextureRect.texture = sprite
	$VBoxContainer/itemName.text = item_name
