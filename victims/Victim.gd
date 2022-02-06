extends "res://sprites/SpriteBase.gd"

signal victim_rescued()

export(String) var animation_name = "Help"

const POINTS_SCORED = 120

onready var animation_player = get_node("Area2D/AnimationPlayer")
onready var audio_player = get_node("Area2D/AudioStreamPlayer")
onready var state_machine = get_node("StateMachine")

var _has_intersectedPlayer = false

func _ready():
	if animation_player:
		animation_player.play(animation_name)

func _on_Area2D_body_entered(body):
	if  body.name  == "Player":
		_has_intersectedPlayer = true

func is_rescued():
	return _has_intersectedPlayer



func broadcast_rescued():	
	# broad cast event (used by the level script to check for level over)
	emit_signal("victim_rescued")	
	
func animate_and_dequeue():
	animation_player.play("Rescued")
	audio_player.play()
	yield(animation_player, "animation_finished")	
	queue_free()




