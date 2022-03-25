#
# A simple script to move a sprite along a path, hosted in a derived PathFollower2D
#
extends PathFollow2D

export var run_speed = 1


# Holds the current (and initial) direction along the path, incrementing or decrementing
export var incrementing = true

#
# if true the sprite will have it's image flipped horizontally when the sprite turns
#
export var flip_h_on_turn = false

#
# if true the sprite will have it's image flipped verically when the sprite turns
#
export var flip_v_on_turn = false


onready var sprite = $AnimatedSprite

func _process(delta):
	var new_pos = 0
	var step = run_speed * delta
	if (incrementing):
		new_pos = unit_offset + step
		if (new_pos >= 1):
			_turn()
	else:
		new_pos = unit_offset - step
		if (new_pos <= 0):
			_turn()
	unit_offset =  clamp(new_pos, 0, 1)

func _turn():
	incrementing = !incrementing
	if (flip_h_on_turn):
		sprite.flip_h = !sprite.flip_h
	if (flip_v_on_turn):
		sprite.flip_v = !sprite.flip_v
