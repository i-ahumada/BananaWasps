extends Control


@export var main_menu_scene: PackedScene
@export var good_ending: Resource
@export var bad_ending: Resource
@export var alternative_ending: Resource


func _ready():
	if global.ending == 0:
		$TextureRect.texture = good_ending
		$EndText/Text.bbcode_text = """[center]Nice! you got to try BananaWasp's new plate, good job!

 [i]We can worry about Luke's house afterwards[/i][/center]"""
	elif global.ending == 1:
		$TextureRect.texture = bad_ending
		$EndText/Text.bbcode_text = """[center]Oops! time's up, you've blown up to pieces, tough luck.

 [i]How did that new menu item taste like? Guess you'll never know.[/i][/center]"""
	else:
		$TextureRect.texture = alternative_ending
		$EndText/Text.bbcode_text = """[center]Why?

 [i]Could've gone to BananaWasp's together.[/i][/center]"""


func _on_main_menu_pressed():
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_exit_pressed():
	get_tree().quit()
