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
var active_ladders: Dictionary = {}

# conveyers the player is currently over
var active_conveyors: Dictionary = {}
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
		var deltaX = active_ladders[active_ladders.keys()[0]].x - sprite.global_position.x
		set_motion(deltaX*10, -CLIMB_VELOCITY)
		animation_player.play()
	elif Input.is_action_pressed("ui_down") and is_on_ladder():
		var deltaX = active_ladders[active_ladders.keys()[0]].x - sprite.global_position.x
		set_motion(deltaX*10, CLIMB_VELOCITY)
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




		

# collision with a ladder section detected
func _ladder_status_changed(tileRid: RID, centerOfTile: Vector2, is_entry: bool):
	print("ladder status changed is entry = " + str(is_entry))
	if is_entry:
		if !active_ladders.has(tileRid):
			active_ladders[tileRid] = centerOfTile
	else:
		if active_ladders.has(tileRid):
			active_ladders.erase(tileRid)

func _on_ladder_collisions_layer_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	var centerOfTile: Vector2 = _get_tile_center_in_global_coords(body_rid, body, body_shape_index, local_shape_index)
	
	# passin the coords of the center this will allow us to slide fred until he 
	# is centered on the ladder and not hitting platforms at the top
	_ladder_status_changed(body_rid, centerOfTile,   true)

func _on_ladder_collisions_layer_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	_ladder_status_changed(body_rid, Vector2.ZERO,  false)


func is_standing_on_conveyer():
	var res = !active_conveyors.is_empty() && is_on_floor() && active_conveyors[active_conveyors.keys()[0]].y > global_position.y
	return res

# -> add a custom collision layer to fren and extend the area down a little
func _on_conveyer_collision_layer_body_shape_entered(body_rid: RID, body: TileMapLayer, body_shape_index: int, local_shape_index: int) -> void:
	if !active_conveyors.has(body_rid):
		var centerOfTile: Vector2 = _get_tile_center_in_global_coords(body_rid, body, body_shape_index, local_shape_index)
		active_conveyors[body_rid] = centerOfTile
		var tileCoords = body.get_coords_for_body_rid(body_rid)
		var tile_data = body.get_cell_tile_data(tileCoords)
		var direction = tile_data.get_custom_data_by_layer_id(0)
		if direction == "right" :
			current_conveyor_direction = ConveyorBelt.DIRECTION_RIGHT
		else :
			current_conveyor_direction = ConveyorBelt.DIRECTION_LEFT


func _on_conveyer_collision_layer_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if active_conveyors.has(body_rid):
		active_conveyors.erase(body_rid)
	if (active_conveyors.is_empty()):
		current_conveyor_direction = ConveyorBelt.DIRECTION_NONE


#
# From a collision with a tile map layer, map the collided cell into global coordinates
#
# returns - A Vector2D thyat is the center of the intersected cell
#
func _get_tile_center_in_global_coords(body_rid: RID, tilemap: TileMapLayer, body_shape_index: int, local_shape_index: int) -> Vector2:
	# Get the tile’s cell coordinates from the shape index
	var cell = tilemap.get_coords_for_body_rid(body_rid)

	# Convert cell to local position
	var local_pos = tilemap.map_to_local(cell)
	
	# Convert local position to global position
	return tilemap.to_global(local_pos)
