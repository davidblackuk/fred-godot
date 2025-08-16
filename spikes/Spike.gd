@tool
extends Node2D

signal player_hit_spike()

@export var spike_type = 0  # (int, "SPIKE UP", "SPIKE DOWN", "FILL", "BUSH", "CPCFLAME", "WOOD")
@export var spike_color = Palette.red # (Color, RGB)

@onready var sprite = get_node("Area2D/Sprite2D")
@onready var audio_player = get_node("AudioStreamPlayer")
@onready var animation_player = get_node("Area2D/AnimationPlayer")

func _ready():
	sprite.frame = spike_type
	sprite.modulate = spike_color

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !GameManager.game_state.god_mode):
		audio_player.play()
		animation_player.play("Hit")
		emit_signal("player_hit_spike")
