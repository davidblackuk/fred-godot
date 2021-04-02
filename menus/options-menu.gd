extends Control

onready var fader = get_node("FadeToBlack")
onready var back_button = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/Back")
onready var show_debug_check_box = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/ShowDebug")
onready var god_mode_check_box = get_node("VBoxOuter/ContentArea/ButtonContainer/VBoxContainer/GodMode")



var scene_to_load = null

func _ready():
	fader.fade_in()
	back_button.grab_focus()
	show_debug_check_box.pressed = GameStateManager.debug_mode
	god_mode_check_box.pressed = GameStateManager.god_mode


func _continue_pressed():
	pass # Replace with function body.




func _on_Back_pressed():
	scene_to_load = "res://menus/main-menu.tscn";
	fader.fade_out()


func _on_ShowDebug_toggled(button_pressed):
	GameStateManager.debug_mode = button_pressed


func _on_GodMode_toggled(button_pressed):
	GameStateManager.god_mode = button_pressed


func _on_FadeToBlack_fade_out_complete():
	get_tree().change_scene(scene_to_load)
