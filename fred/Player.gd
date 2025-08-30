extends CharacterBody2D

const HORIZONTAL_VELOCITY = 150
const JUMP_VELOCITY = 320
const FLOOR_NORMAL = Vector2.UP
const SNAP_DIRECTION = Vector2.DOWN
const SNAP_LENGTH = 32


const CLIMB_VELOCITY = 150
const GRAVITY = 10
const FALL_HEIGHT_FOR_DEATH = -95

@export var fred_style = "ZX"  # (String, "ZX", "CPC", "AMIGA", "PC")

var zx_image = preload("res://images/fred/fred.png")
var cpc_image = preload("res://images/fred/fred-cpc.png")


@onready var animation_player = get_node("AnimationPlayer")
@onready var sprite = get_node("Sprite2D")

@onready var fred_is_dead_stream_player: AudioStreamPlayer2D = $FredIsDeadStreamPlayer

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
	set_velocity(motion)
	# TODOConverter3To4 looks that snap in Godot 4 is float, not vector like in Godot 3 - previous value `snap_vector`
	set_up_direction(FLOOR_NORMAL)
	set_floor_stop_on_slope_enabled(false)
	move_and_slide()
	motion = velocity
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
	return not active_ladders.is_empty()

# collision with a ladder section detected
func _ladder_status_changed(ladder_node, is_entry):
	print("ladder status changed is entry = " + str(is_entry))
	if is_entry:
		active_ladders.append(ladder_node)
		print("Active ladders has " + str(active_ladders.size()) + " elements" )
	else:
		active_ladders.erase(ladder_node)	
		print("Active ladders has " + str(active_ladders.size()) + " elements" )

func is_standing_on_conveyer():
	return !active_conveyors.is_empty() && is_on_floor() && active_conveyors[0].global_position.y > global_position.y
		
func _conveyor_status_changed(conveyor_node, is_entry):
	if is_entry:
		active_conveyors.append(conveyor_node)	
		current_conveyor_direction = conveyor_node.direction
	else:
		active_conveyors.erase(conveyor_node)
		if (active_conveyors.is_empty()):
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
	await animation_player.animation_finished
	# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func climb():
	if is_on_floor():
		snap_vector = Vector2.ZERO
	arrest_all_motion()
	if Input.is_action_pressed("ui_up") and is_on_ladder():
		# move center player to center tile?
		set_motion(0, -CLIMB_VELOCITY)
		animation_player.play()
	elif Input.is_action_pressed("ui_down") and is_on_ladder():
		set_motion(0, CLIMB_VELOCITY)
		animation_player.play()
	else:
		animation_player.stop(false)



func fall():
	# when y is below start Y, cancel motion.x
	jump_height = (jump_start_y - global_position.y)
	if jump_height < -90:
		motion.x = 0


func _on_enemy_collision_body_entered(body: Node2D) -> void:
	if (!GameManager.game_state.god_mode):
		fred_is_dead_stream_player.play()
		_fred_is_dead() 
	print("hit")

func _on_ladder_collisions_layer_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("Ladder entry")
	_ladder_status_changed(body_rid,   true)

func _on_ladder_collisions_layer_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("Ladder exit")
	_ladder_status_changed(body_rid,   false)
