extends "res://sprites/SpriteBase.gd"

signal victim_rescued()

enum VictimState { WAITING, RESCUED }

var state = VictimState.WAITING
const points_scored = 120


func _on_Area2D_body_entered(body):
	if state == VictimState.WAITING && body.name  == "Player":
		var animation_player = get_node("Area2D/AnimationPlayer")
		var audio_player = get_node("Area2D/AudioStreamPlayer")
		GameState.add_score(points_scored)
		emit_signal("victim_rescued")
		animation_player.play("Rescued")
		audio_player.play()
		state = VictimState.RESCUED
		yield(animation_player, "animation_finished")	
		queue_free()
