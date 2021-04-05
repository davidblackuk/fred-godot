extends Control

onready var fader = get_node("Fader")
onready var new_game_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/NewGame")
onready var continue_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/Continue")
onready var load_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/Load")
onready var save_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/Save")
onready var save_confirm = get_node("SaveConfimation")
onready var load_confirm = get_node("LoadConfirmation")


var scene_to_load = null

func _ready():
	fader.fade_in()
	set_button_state()
	
func set_button_state():
	var has_current_level = GameStateManager.current_level != null

	load_button.disabled = !GameStateManager.save_file_exists()
	continue_button.disabled = !has_current_level
	save_button.disabled = !has_current_level
	
	if !has_current_level:
		new_game_button.grab_focus()
	else:
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

func _on_Load_pressed():
	GameStateManager.load()
	set_button_state()
	load_confirm.popup_centered()


func _on_Save_pressed():
	GameStateManager.save()
	save_confirm.popup_centered()
