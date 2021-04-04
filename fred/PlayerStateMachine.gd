extends "res://state-machine/StateMachineWithPDA.gd"

class_name Player

const STATE_WALKING = "walking"
const STATE_JUMPING = "jumping"
const STATE_CLIMBING = "climbing"
const STATE_DYING = "dying"
const STATE_DEAD = "dead"
const STATE_IDLE = "idle"
const STATE_CONVEYED = "conveyed"

onready var _climbing_state_script = get_node("../States/Climbing")
onready var _dead_state_script = get_node("../States/Dead")
onready var _dying_state_script = get_node("../States/Dying")
onready var _idle_state_script = get_node("../States/Idle")
onready var _jumping_state_script = get_node("../States/Jumping")
onready var _walking_state_script = get_node("../States/Walking")
onready var _conveyed_state_script = get_node("../States/Conveyed")

func _ready():
	add_state(STATE_WALKING, _walking_state_script)
	add_state(STATE_JUMPING, _jumping_state_script)
	add_state(STATE_CLIMBING, _climbing_state_script)
	add_state(STATE_DYING, _dying_state_script)
	add_state(STATE_DEAD, _dead_state_script)
	add_state(STATE_IDLE, _idle_state_script)
	add_state(STATE_CONVEYED, _conveyed_state_script)
	call_deferred("_set_state", STATE_IDLE)

