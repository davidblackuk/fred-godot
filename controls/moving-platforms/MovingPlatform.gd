tool
extends Node2D


export(int) var image_frame = 0

onready var platform_sprite = get_node("Platform/Sprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	platform_sprite.frame = image_frame

