extends Control


@export var game: PackedScene


func _on_start_pressed():
	get_tree().change_scene_to_packed(game)


func _on_exit_pressed():
	get_tree().quit()


func _on_how_to_pressed():
	$Instructions.visible = !$Instructions.visible 
