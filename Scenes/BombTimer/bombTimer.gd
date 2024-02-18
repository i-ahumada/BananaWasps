extends Control

var time = 210.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta
	$ColorRect/Minutes.text = "%02d" % floor(time / 60.0)
	$ColorRect/Seconds.text = "%02d" % floor(fmod(time, 60.0))
	if time <= 0:
		global.ending = 1
		get_tree().change_scene_to_file("res://Scenes/Endscreen/endscreen.tscn")
