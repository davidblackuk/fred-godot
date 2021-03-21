extends KinematicBody2D

signal update_hud()


const HORIZONTAL_VELOCITY = 150
const JUMP_VELOCITY = 320
const CLIMB_VELOCITY = 150
const GRAVITY = 10

onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

var motion = Vector2()

var active_ladders = []

	
func process_movement(delta):
	motion = move_and_slide(motion, Vector2.UP)
	
func process_gravity():
	motion.y += GRAVITY
	
func is_on_ladder():
	return not active_ladders.empty()

func _ladder_status_changed(ladder_node, is_entry):
	if is_entry:
		active_ladders.append(ladder_node)
	else:
		active_ladders.erase(ladder_node)	
		


func walk():	
	if Input.is_action_pressed("ui_left"):
		motion.x = -HORIZONTAL_VELOCITY
		sprite.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		sprite.set_flip_h(false)		
		motion.x = HORIZONTAL_VELOCITY
	
		

func climb():
	motion.x = 0
	motion.y = 0	
	if Input.is_action_pressed("ui_up") and is_on_ladder():
		var deltaX = active_ladders[0].global_position.x - sprite.global_position.x
		motion.x = deltaX*10
		motion.y = -CLIMB_VELOCITY
		animation_player.play()
	elif Input.is_action_pressed("ui_down") and is_on_ladder():
		var deltaX = active_ladders[0].global_position.x - sprite.global_position.x
		motion.x = deltaX*10
		motion.y = CLIMB_VELOCITY
		animation_player.play()
	else:
		animation_player.stop(false)

func jump():
	pass

func fall():
	# when y is below start Y, cancel motion.x
	pass


