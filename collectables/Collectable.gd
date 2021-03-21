extends Node2D

const LOW 		= 0
const MEDIUM	= 1
const HIGH 		= 2
const OMG 		= 3

#           0 (22)  1 (44)    2 (66) 3 (88)
export(int, "LOW", "MEDIUM", "HIGH", "OMG") var reward_level = 0 

func _ready():
	match reward_level:
		LOW:
			modulate =  Palette.white
		MEDIUM:
			modulate =  Palette.bright_cyan
		HIGH:
			modulate =  Palette.bright_green
		OMG:
			modulate =  Palette.bright_yellow
			

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		GameState.add_score((reward_level+1) * 22)
		queue_free()
