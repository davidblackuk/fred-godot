extends Path2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
# flips the sprite at the halfway point
func _process(delta):
	var follower = get_node("./PathFollow2D")
	var enemy = get_node("./PathFollow2D/Enemy")
	var new_offset = follower.get_offset() + 100 * delta
	follower.set_offset(new_offset)
	enemy.flip_horizontal = (follower.unit_offset < 0.5)
