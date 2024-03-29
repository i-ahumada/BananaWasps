extends Control

@export var item_scene: PackedScene
var item_array: Array = []: get = get_items, set = set_items

func set_items(item_name):
	if (!item_array.has("Water")):
		_on_item_pickup_handler_item_pickup_handle(item_name, load("res://Sprites/Items/Water.png"))
	
	

func get_items():
	return item_array


func _on_item_pickup_handler_item_pickup_handle(item_name, sprite):
	item_array.append(item_name)
	
	var item_node = item_scene.instantiate()
	item_node.item_name = item_name
	item_node.sprite = sprite
	$MarginContainer/TextureRect/itemContainer.add_child(item_node)
