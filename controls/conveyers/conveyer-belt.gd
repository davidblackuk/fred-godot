extends Node2D

class_name ConveyorBelt

const DIRECTION_NONE = -1
const DIRECTION_LEFT = 0
const DIRECTION_RIGHT = 1

@export var direction = DIRECTION_LEFT # (int, "LEFT", "RIGHT")
@export var conveyor_tint = Color.WHITE  # (Color, RGB)

@onready var sprite = $AnimatedSprite2D

signal conveyor_status_changed(conveyor_node, is_entry)

func _ready():
	sprite.flip_h = (direction == DIRECTION_RIGHT)
	sprite.modulate = conveyor_tint
	add_to_group("Conveyors")

func _on_player_detection_area_body_entered(body):
	if body.name == "Player":
		emit_signal("conveyor_status_changed", self, true)

func _on_player_detection_area_body_exited(body):
	if body.name == "Player":
		emit_signal("conveyor_status_changed", self, false)
