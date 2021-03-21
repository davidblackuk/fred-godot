extends "res://common/StateMachine.gd"

const STATE_WALKING = "walking"
const STATE_JUMPING = "jumping"
const STATE_FALLING = "falling"
const STATE_CLIMBING = "climbing"
const STATE_DYING = "dying"
const STATE_DEAD = "dead"
const STATE_IDLE = "idle"



func _ready():
	add_state(STATE_WALKING)
	add_state(STATE_JUMPING)
	add_state(STATE_FALLING)
	add_state(STATE_CLIMBING)
	add_state(STATE_DYING)
	add_state(STATE_DEAD)
	add_state(STATE_IDLE)
	call_deferred("set_state", STATE_WALKING)

func _state_logic(delta):
	parent.process_gravity()

	match state:
		STATE_WALKING:
			parent.walk()
		STATE_CLIMBING:
			parent.climb()
		STATE_JUMPING:
			parent.jump();
		STATE_FALLING:
			parent.fall();
			
		
	parent.process_movement(delta)



func _get_transition(delta):
	match state:
		STATE_DYING:
			if parent.is_on_floor():
				return STATE_DEAD
		STATE_WALKING:
			if parent.motion.y > 0:
				return STATE_FALLING
			elif Input.is_action_pressed("ui_up") && parent.is_on_ladder():
				return STATE_CLIMBING
			elif Input.is_action_pressed("ui_down") && parent.is_on_ladder() && !parent.is_on_floor():
				return STATE_CLIMBING
			elif Input.is_action_just_pressed("ui_jump") && parent.is_on_floor():
				return STATE_JUMPING
			elif !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
				return STATE_IDLE
		STATE_IDLE:
			if Input.is_action_pressed("ui_up") && parent.is_on_ladder():
				return STATE_CLIMBING
			elif Input.is_action_pressed("ui_down") && parent.is_on_ladder() :
				return STATE_CLIMBING
			elif Input.is_action_just_pressed("ui_jump") && parent.is_on_floor():
				return STATE_JUMPING
			elif Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
				return STATE_WALKING
		STATE_JUMPING:
			if parent.motion.y > 0:
				return STATE_FALLING
		STATE_FALLING:
			if parent.is_on_floor():
				return STATE_IDLE
			
		STATE_CLIMBING:
			if  Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				return STATE_WALKING
				
	# handles state dead which is never transitioned out of. Death is a one way street
	return null

	
func _enter_state(new_state, old_state):
	print(old_state, " -> ", new_state)
	match state:
		STATE_JUMPING:
			parent.motion.y = -parent.JUMP_VELOCITY
		STATE_IDLE:
			parent.motion.x = 0
			parent.animation_player.play("Idle")
		STATE_WALKING:
			parent.animation_player.play("Walk")
		STATE_CLIMBING:
			parent.animation_player.play("Climb")

		
	
func _exit_state(old_state, new_state):
	pass
