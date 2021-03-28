extends Node2D

onready var fader = get_node("FadeToBlack")
onready var new_game_button = get_node("VBoxOuter/MainArea/ButtonContainer/VBoxContainer/NewGame")
onready var continue_button = get_node("VBoxOuter/MainArea/ButtonContainer/VBoxContainer/Continue")

var scene_to_load = null

func _ready():
	new_game_button.grab_focus()


func _new_game_pressed():
	scene_to_load = "res://Levels/Level 001.tscn"
	fader.fade()

func _continue_pressed():
	pass # Replace with function body.


func _options_pressed():
	pass # Replace with function body.


func _on_fade_complete():
	get_tree().change_scene(scene_to_load)
