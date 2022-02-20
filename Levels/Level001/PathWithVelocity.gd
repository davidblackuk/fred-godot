extends Path2D


export var velocity = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var follower = get_node("./PathFollow2D")
	follower.set_offset(follower.get_offset() + velocity * delta)
