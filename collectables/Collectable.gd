extends Node2D

signal item_collected(reward)

enum RewardLevel {
	LOW = 0,
	MEDIUM = 1,
	HIGH = 2,
	OMG = 3
}

const SCORE_MULTIPLIER = 22

var collected = false

#           0 (22)  1 (44)    2 (66) 3 (88)
@export var reward_level: RewardLevel = RewardLevel.LOW

@export var speed_scale = 1.0

@export var starting_frame = 0 # (int, 7)

@onready var animated_sprite = get_node("Area2D/AnimatedSprite2D")


func _ready():
	color_according_to_reward()
	animated_sprite.speed_scale = speed_scale
	animated_sprite.frame = starting_frame
	

func color_according_to_reward():
	match reward_level:
		RewardLevel.LOW:
			modulate =  Palette.white
		RewardLevel.MEDIUM:
			modulate =  Palette.bright_cyan
		RewardLevel.HIGH:
			modulate =  Palette.bright_green
		RewardLevel.OMG:
			modulate =  Palette.bright_yellow

func _on_Area2D_body_entered(body):
	if body.name == "Player" && !collected:
		collected = true
		emit_signal("item_collected", (reward_level+1) * SCORE_MULTIPLIER)
		$AnimationPlayer.play("Collected")


func _on_animation_finished(_anim_name):
	queue_free() # Replace with function body.
