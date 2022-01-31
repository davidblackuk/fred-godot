
extends Node2D

var time_functions = TimeFunctions.new()

signal fade_out_complete()
signal fade_in_complete()

onready var player = get_node("AnimationPlayer")
onready var color_rect = get_node("ColorRect")

onready var text = get_node("Text")

onready var labelTimeValue = get_node("Text/Time/labelTimeValue")
onready var labelPercentValue = get_node("Text/Items/LabelItemsColectedValue")

var is_level_record = GameManager.last_level_was_high_score

func _ready():
	if !is_level_record:
		text.hide()
	else:
		labelPercentValue.text =  "%d%%" % GameManager.last_level_percent
		labelTimeValue.text = time_functions.msec_to_hours_minutes_seconds(GameManager.last_level_msecs)

func fade_out():
	color_rect.color = Color.transparent
	show()
	player.play("fade_out")
		
func fade_in():
	color_rect.color = Color.black
	show()
	if !is_level_record:
		player.play("fade_in")
	else:
		player.play("fade_in_slow")

func _on_animation_finished(anim_name):
	if (anim_name == "fade_out"):
		emit_signal("fade_out_complete")
	else:
		hide()
		emit_signal("fade_in_complete")

