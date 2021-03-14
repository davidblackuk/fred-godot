extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint == false:
		queue_free()

