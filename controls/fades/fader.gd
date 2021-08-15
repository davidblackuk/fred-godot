
extends Node2D


signal fade_out_complete()
signal fade_in_complete()

onready var player = get_node("AnimationPlayer")
onready var color_rect = get_node("ColorRect")

onready var text = get_node("Text")

var is_level_record = false

func _ready():
	if !GameManager.last_level_was_highscore:
		text.hide()

func fade_out():
	color_rect.color = Color.transparent
	show()
	player.play("fade_out")

func fade_in():
	color_rect.color = Color.black
	show()
	player.play("fade_in")

func _on_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		emit_signal("fade_out_complete")
	else:
		hide()
		emit_signal("fade_in_complete")

