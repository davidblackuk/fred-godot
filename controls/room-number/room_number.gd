@tool

extends Node2D

@export var level_number: String

@onready var value: Label = $Value

#  Only show this at design time
func _ready() -> void:
	if Engine.is_editor_hint() == false:
		queue_free()
	else:
		value.text = level_number
		print("level number: " + level_number)
