extends ClickableArea2D


@export var safe_screen_scene: PackedScene


func _on_area_clicked():
	var safe_screen_instance = safe_screen_scene.instantiate()
	get_parent().get_parent().add_child(safe_screen_instance)
