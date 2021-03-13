extends "res://sprites/SpriteBase.gd"

signal victim_rescued()

enum VictimState { WAITING, RESCUED }

var state = VictimState.WAITING

func _on_Area2D_body_entered(body):
	if state == VictimState.WAITING && body.name  == "Player":
		var sprite = get_node("Area2D/Sprite") 
		var player = get_node("Area2D/AnimationPlayer")
		player.play("Rescued")
		state = VictimState.RESCUED
		emit_signal("victim_rescued")
		
	# Replace with function body.
