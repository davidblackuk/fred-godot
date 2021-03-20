extends "res://sprites/SpriteBase.gd"

signal victim_rescued()

const points_scored = 120

onready var animation_player = get_node("Area2D/AnimationPlayer")
onready var audio_player = get_node("Area2D/AudioStreamPlayer")
onready var state_machine = get_node("StateMachine")

var _has_intersectedPlayer = false

func _on_Area2D_body_entered(body):
	if  body.name  == "Player":
		_has_intersectedPlayer = true				
		
func is_rescued():
	return _has_intersectedPlayer



func show_rescued():
	GameState.add_score(points_scored)
	emit_signal("victim_rescued")
	animation_player.play("Rescued")
	audio_player.play()
	yield(animation_player, "animation_finished")	
	queue_free()
