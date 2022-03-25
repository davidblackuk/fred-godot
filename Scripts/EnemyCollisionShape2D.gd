extends CollisionShape2D

signal fred_is_dead()

export(String) var animation_name = "Bulb"

func _ready():
	pass
	



func _on_StaticBody2D_body_entered(body):
	if body.name == "Player" && !GameManager.game_state.god_mode:
		emit_signal("fred_is_dead")

