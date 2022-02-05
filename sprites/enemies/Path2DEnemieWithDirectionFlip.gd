extends Path2D

signal fred_is_dead()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# flips the sprite at the halfway point
func _process(delta):
	var follower = get_node("./PathFollow2D")
	var sprite = get_node("./PathFollow2D/Area2D/Sprite")
	var new_offset = follower.get_offset() + 100 * delta
	follower.set_offset(new_offset)
	sprite.flip_h = (follower.unit_offset < 0.5)


func _on_Area2D_body_entered(body):
	if body.name == "Player" && !GameManager.game_state.god_mode:
		emit_signal("fred_is_dead")
