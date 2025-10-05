@tool
extends Node2D

@onready var animation_player:AnimationPlayer = get_node("AnimationPlayer")
@onready var sprite:Sprite2D  = get_node("Sprite2D")

@export var crumble_tint = Palette.yellow  # (Color, RGB)

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
	animation_player.pause()
	


func _on_animation_finished(anim_name):
	queue_free()
