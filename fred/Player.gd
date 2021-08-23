extends KinematicBody2D

const HORIZONTAL_VELOCITY = 150
const JUMP_VELOCITY = 320
const FLOOR_NORMAL = Vector2.UP
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 32


const CLIMB_VELOCITY = 150
const GRAVITY = 10
const FALL_HEIGHT_FOR_DEATH = -95

export(String, "ZX", "CPC", "AMIGA", "PC") var fred_style = "ZX" 

var zx_image = preload("res://images/fred/fred.png")
var cpc_image = preload("res://images/fred/fred-cpc.png")


onready var animation_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

var motion = Vector2()
var snap_vector = SNAP_DIRECTION * SNAP_LENGTH
var has_enemy_hit = false


# ladders the player is currently over
var active_ladders = []

# conveyers the player is currently over
var active_conveyors = []
var current_conveyor_direction = ConveyorBelt.DIRECTION_NONE

# follows the current jump height, negative on the way up, positive on falling after reaching 
# initial position. Used to check if fall distance exceeds the death height. most probably this 
# could be achieved using a ray cast when falling is set true. THough it is also used to cancel 
# x motion when we reach the bottom of tyhe artc of jumping
var jump_height = 0
var jump_start_y = 0
	
func _ready():
	if fred_style == "ZX":
		sprite.set_texture(zx_image)	
	else:
		sprite.set_texture(cpc_image)	

func process_movement(_delta):
	motion = move_and_slide_with_snap(motion, snap_vector, FLOOR_NORMAL, false)
	if is_on_floor() and snap_vector == Vector2.ZERO:
		snap_vector = SNAP_DIRECTION * SNAP_LENGTH		
		
func process_gravity():
	motion.y += GRAVITY

func arrest_all_motion():
	motion.x = 0
	motion.y = 0
	
func set_motion(x, y):
	motion.x = x
	motion.y = y
	
# is fred over a ladder
func is_on_ladder():
	return not active_ladders.empty()

# collision with a ladder section detected
func _ladder_status_changed(ladder_node, is_entry):
	if is_entry:
		active_ladders.append(ladder_node)
	else:
		active_ladders.erase(ladder_node)	

func is_standing_on_conveyer():
	return !active_conveyors.empty() && is_on_floor() && active_conveyors[0].global_position.y > global_position.y
		
func _conveyor_status_changed(conveyor_node, is_entry):
	if is_entry:
		active_conveyors.append(conveyor_node)	
		current_conveyor_direction = conveyor_node.direction
	else:
		active_conveyors.erase(conveyor_node)
		if (active_conveyors.empty()):
			current_conveyor_direction = ConveyorBelt.DIRECTION_NONE
	
		
		
#enemy sprite collision
func _fred_is_dead():
	has_enemy_hit = true

#has the fall range exceeded the height past which fred dies
func has_fallen_to_death():
	return jump_height < FALL_HEIGHT_FOR_DEATH && !GameManager.game_state.god_mode

func die():
	arrest_all_motion()
	animation_player.play("Death")
	yield(animation_player, "animation_finished")
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func climb():
	if is_on_floor():
		snap_vector = Vector2.ZERO
	arrest_all_motion()
	if Input.is_action_pressed("ui_up") and is_on_ladder():
		var deltaX = active_ladders[0].global_position.x - sprite.global_position.x
		set_motion(deltaX*10, -CLIMB_VELOCITY)
		animation_player.play()
	elif Input.is_action_pressed("ui_down") and is_on_ladder():
		var deltaX = active_ladders[0].global_position.x - sprite.global_position.x
		set_motion(deltaX*10, CLIMB_VELOCITY)
		animation_player.play()
	else:
		animation_player.stop(false)



func fall():
	# when y is below start Y, cancel motion.x
	jump_height = (jump_start_y - global_position.y)
	if jump_height < -90:
		motion.x = 0


