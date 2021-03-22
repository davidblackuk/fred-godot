extends "res://state-machine/StateMachineWithPDA.gd"

class_name VictimStateMachine

const STATE_WAITING = "waiting"
const STATE_RESCUED = "rescued"

onready var script_waiting = get_node("../States/Waiting")
onready var script_rescued = get_node("../States/Rescued")

func _ready():
	add_state(STATE_WAITING, script_waiting)
	add_state(STATE_RESCUED, script_rescued)
	call_deferred("_set_state", STATE_WAITING)



