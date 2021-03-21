extends Path2D

export var velocity = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var follower = get_node("./PathFollow2D")
	follower.set_offset(follower.get_offset() + (100 * velocity) * delta)
