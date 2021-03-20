extends Path2D

func _process(delta):
	var follower = get_node("./PathFollow2D")
	follower.set_offset(follower.get_offset() + 100 * delta)
