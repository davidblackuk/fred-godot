extends Node2D

const LOW 		= 0
const MEDIUM	= 1
const HIGH 		= 2
const OMG 		= 3

const SCORE_MULTIPLIER = 22

#           0 (22)  1 (44)    2 (66) 3 (88)
export(int, "LOW", "MEDIUM", "HIGH", "OMG") var reward_level = 0 

export var speed_scale = 1.0
export(int, 7) var starting_frame = 0

onready var animated_sprite = get_node("Area2D/AnimatedSprite")


func _ready():
	color_according_to_reward()
	animated_sprite.speed_scale = speed_scale
	animated_sprite.frame = starting_frame
	

func color_according_to_reward():
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
		GameStateManager.add_score((reward_level+1) * SCORE_MULTIPLIER)
		$AnimationPlayer.play("Collected")


func _on_animation_finished(anim_name):
	queue_free() # Replace with function body.
