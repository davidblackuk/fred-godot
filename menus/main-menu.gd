extends Control

onready var fader = get_node("Fader")
onready var new_game_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/NewGame")

var scene_to_load = null

func _ready():
	fader.fade_in()
	new_game_button.grab_focus()
	pass

func _new_game_pressed():
	scene_to_load = "res://Levels/Level 001.tscn"
	fader.fade_out()

func _continue_pressed():
	pass # Replace with function body.


func _options_pressed():
	scene_to_load = "res://menus/options-menu.tscn"
	fader.fade_out()


func _on_quit_pressed():
	scene_to_load = "QUIT"
	fader.fade_out()


func _on_Fader_fade_out_complete():
	if scene_to_load != "QUIT":
		get_tree().change_scene(scene_to_load)
	else:
		get_tree().quit()

