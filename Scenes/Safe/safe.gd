extends ClickableArea2D


@export var safe_screen_scene: PackedScene


func _on_area_clicked():
	get_tree().paused = true
	
	$safeScreen.visible = true


func _on_safe_screen_safe_opened():
	$CollisionShape2D.disabled = true
	$Sprite2D.texture = load("res://Sprites/Safe/Safe_opened.png")
	get_node("/root/Room/ItemPickupHandler/Keys").visible = true
