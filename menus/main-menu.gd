extends Control

onready var fader = get_node("Fader")
onready var new_game_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/NewGame")
onready var continue_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/Continue")

var scene_to_load = null

func _ready():
	fader.fade_in()
	
	
	if (GameStateManager.current_level == null):
		continue_button.disabled = true
		new_game_button.grab_focus()
	else:
		continue_button.disabled = false
		continue_button.grab_focus()

func _new_game_pressed():
	GameStateManager.reset()
	_start()

func _continue_pressed():
	_start()

func _start():
	scene_to_load = GameStateManager.current_level
	fader.fade_out()

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

