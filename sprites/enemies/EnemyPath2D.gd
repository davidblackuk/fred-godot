extends Path2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var follower = get_node("./PathFollow2D")
	follower.set_offset(follower.get_offset() + 100 * delta)
