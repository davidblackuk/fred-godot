extends Node

signal victim_rescued()

@export var animation_name: String = "Help"

const POINTS_SCORED = 120

@onready var sprite: Sprite2D = $Area2D/Sprite2D

var _flip_h = false

@onready var animation_player = get_node("Area2D/AnimationPlayer")
@onready var audio_player = get_node("Area2D/AudioStreamPlayer")
@onready var state_machine = get_node("StateMachine")

@export var flip_horizontal: bool: get = get_flip_h, set = set_flip_h

var _has_intersectedPlayer = false

func _ready():
	if sprite:
		sprite.flip_h = _flip_h
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
	await animation_player.animation_finished	
	queue_free()


func get_flip_h():
	return _flip_h

func set_flip_h(value):
	_flip_h = value
	if sprite:
		sprite.set_flip_h(value)
