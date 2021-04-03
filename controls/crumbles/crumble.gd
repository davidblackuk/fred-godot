tool
extends Node2D

onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

export(Color, RGB) var crumble_tint = Palette.yellow 

func _ready():
	sprite.modulate = crumble_tint


func _on_animation_control_area_body_entered(body):
	if body.name != "Player":
		return
	if (body.global_position.y < global_position.y && body.is_on_floor()):
		animation_player.play("Crumbling")
		
func _on_animation_control_area_body_exited(body):
	if body.name != "Player":
		return
	animation_player.stop(false)
	


func _on_animation_finished(anim_name):
	queue_free()
