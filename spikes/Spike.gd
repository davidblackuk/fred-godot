tool
extends Node2D

signal player_hit_spike()

export(int, "SPIKE UP", "SPIKE DOWN", "FILL", "BUSH", "CPCFLAME", "WOOD") var spike_type = 0 
export(Color, RGB) var spike_color = Palette.red

onready var sprite = get_node("Area2D/Sprite")
onready var audio_player = get_node("AudioStreamPlayer")
onready var animation_player = get_node("Area2D/AnimationPlayer")

func _ready():
	sprite.frame = spike_type
	sprite.modulate = spike_color

func _on_Area2D_body_entered(body):
	if (body.name == "Player" && !GameManager.game_state.god_mode):
		audio_player.play()
		animation_player.play("Hit")
		emit_signal("player_hit_spike")
