extends "res://state-machine/StateMachineWithPDA.gd"

class_name VictimStateMachine

const STATE_WAITING = "waiting"
const STATE_RESCUED = "rescued"

onready var _waiting_state_script = get_node("../States/Waiting")
onready var _rescued_state_script = get_node("../States/Rescued")

func _ready():
	add_state(STATE_WAITING, _waiting_state_script)
	add_state(STATE_RESCUED, _rescued_state_script)
	call_deferred("_set_state", STATE_WAITING)



