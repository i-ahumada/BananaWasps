extends Node


func _ready():
	for items in get_children():
		items.connect("item_pickup", _on_item_pickup, 0)

func _on_item_pickup(item_name: String, sprite: Resource):
	print(item_name + " has been picked up.")
