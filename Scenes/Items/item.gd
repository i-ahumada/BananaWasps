extends ClickableArea2D


@export var sprite: Resource
@export var item_name: String
signal item_pickup(name: String, sprite: Resource)


func _ready():
	$Sprite2D.texture = sprite


func _on_area_clicked():
	item_pickup.emit(item_name, sprite)
	queue_free()
