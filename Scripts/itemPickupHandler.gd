extends Node


signal item_pickup_handle(item_name: String, sprite: Resource)


func _ready():
	for items in get_children():
		items.connect("item_pickup", _on_item_pickup, 0)

func _on_item_pickup(item_name: String, sprite: Resource):
	item_pickup_handle.emit(item_name, sprite)
