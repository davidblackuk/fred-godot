extends Node2D

signal item_collected(reward)

enum RewardLevel {
	GOLD = 0,
	SILVER = 1,
	BRONZE = 2
}

const SCORE_MULTIPLIER = 22

var collected = false

#           0 (22)  1 (44)    2 (66) 3 (88)
@export var reward_level: RewardLevel = RewardLevel.BRONZE

@export var speed_scale = 1.0


@onready var animated_sprite: AnimatedSprite2D = get_node("Area2D/AnimatedSprite2D")


func _ready():
	_set_animation_from_reward_level()
	animated_sprite.speed_scale = speed_scale
	add_to_group("Collectables")
	



func _on_Area2D_body_entered(body):
	if body.name == "Player" && !collected:
		collected = true
		emit_signal("item_collected", _get_reward())
		$AnimationPlayer.play("Collected")


func _on_animation_finished(_anim_name):
	if _anim_name == "Collected":
		queue_free() 
	
func _set_animation_from_reward_level()  -> void :
	match reward_level:
		RewardLevel.GOLD:
			$AnimationPlayer.play("gold")
		RewardLevel.SILVER:
			$AnimationPlayer.play("silver")
		RewardLevel.BRONZE:
			$AnimationPlayer.play("bronze")
			
func _get_reward():
	match reward_level:
		RewardLevel.GOLD:
			return 100
		RewardLevel.SILVER:
			return 50
		RewardLevel.BRONZE:
			return 15
	return 0
	
