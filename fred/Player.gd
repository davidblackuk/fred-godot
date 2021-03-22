extends KinematicBody2D

signal update_hud()

const HORIZONTAL_VELOCITY = 150
const JUMP_VELOCITY = 320
const CLIMB_VELOCITY = 150
const GRAVITY = 10
const FALL_HEIGHT_FOR_DEATH = -95

onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

var motion = Vector2()
var active_ladders = []
var has_enemy_hit = false

# follows the current jump height, negative on the way up, positive on falling after reaching 
# initial position. Used to check if fall distance exceeds the death height. most probably this 
# could be achieved using a ray cast when falling is set true. THough it is also used to cancel 
# x motion when we reach the bottom of tyhe artc of jumping
var jump_height = 0
var jump_start_y = 0
	
func process_movement(delta):
	motion = move_and_slide(motion, Vector2.UP)
	
func process_gravity():
	motion.y += GRAVITY
	
	
# is fred over a ladder
func is_on_ladder():
	return not active_ladders.empty()

# collision with a ladder section detected
func _ladder_status_changed(ladder_node, is_entry):
	if is_entry:
		active_ladders.append(ladder_node)
	else:
		active_ladders.erase(ladder_node)	
		
#enemy sprite collision
func _fred_is_dead():
	has_enemy_hit = true

#has the fall range exceeded the height past which fred dies
func has_fallen_to_death():
	return jump_height < FALL_HEIGHT_FOR_DEATH

func die():
	motion.x = 0
	motion.y = 0
	animation_player.play("Death")
	yield(animation_player, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

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
	jump_height = (jump_start_y - global_position.y)

func fall():
	# when y is below start Y, cancel motion.x
	jump_height = (jump_start_y - global_position.y)
	if jump_height < -82:
		motion.x = 0


