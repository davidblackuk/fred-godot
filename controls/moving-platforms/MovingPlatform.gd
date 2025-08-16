@tool
extends Node2D


@export var image_frame = 0: set = _set_image_frame

@onready var platform_sprite = get_node("Platform/Sprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_image_frame(image_frame)

func _set_image_frame(value):
	platform_sprite.frame = value
