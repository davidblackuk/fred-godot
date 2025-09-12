extends Area2D

# 
# An Aread2d that detects the entry of the play sprite and raises the fred_is_dead signal,
# this node is automatically entered into the Enemies group for binding

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal fred_is_dead()

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	add_to_group("Enemies")

func _on_body_entered(body):
	print ("A " + body.name + " entered an enemy")
	if body.name == "Player" && !GameManager.game_state.god_mode:
		print("emit signal fred is dead from EnemyArea2D")
		emit_signal("fred_is_dead")

func flip_sprite_direction(dir: bool):
	print("flip "+str(dir))
	sprite.flip_h = dir
	
