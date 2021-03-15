extends KinematicBody2D

enum State { WALK, JUMP, CLIMB, DYING, DEAD}

const PLATFORM_COLLISION_BIT = 1
const HORIZONTAL_VELOCITY = 150
const JUMP_VELOCITY = 320
const CLIMB_VELOCITY = 150
const GRAVITY = 10

var motion = Vector2()
var current_state = State.WALK

var active_ladders = []

func _physics_process(_delta):

	process_input()
				
	motion = move_and_slide(motion, Vector2.UP)

func process_input():
	motion.y += GRAVITY
	if current_state == State.DYING:
		dying()
	elif current_state == State.WALK:
		walking()
	elif current_state == State.JUMP:
		jumping()		
	elif current_state == State.CLIMB:
		climbing()		

#
# Fred is walking handle left right, idle or transition to jump / climb
#
func walking():
	var animation_player = get_node("AnimationPlayer")
	var sprite = get_node("Sprite")
	
	if Input.is_action_pressed("ui_up") and is_on_ladder():
		motion.y = -CLIMB_VELOCITY 
		current_state = State.CLIMB
	elif Input.is_action_pressed("ui_down") and is_on_ladder():
		motion.y = CLIMB_VELOCITY 
		current_state = State.CLIMB
	elif Input.is_action_just_pressed("ui_jump") and is_on_floor():
		motion.y = -JUMP_VELOCITY
		current_state = State.JUMP
	elif Input.is_action_pressed("ui_left"):
		motion.x = -HORIZONTAL_VELOCITY
		animation_player.play("Walk")
		sprite.set_flip_h(true)
	elif Input.is_action_pressed("ui_right"):
		animation_player.play("Walk")
		sprite.set_flip_h(false)		
		motion.x = HORIZONTAL_VELOCITY
	else:
		motion.x = 0
		get_node("AnimationPlayer").play("Idle")

#
# Jump state is maintained until we land, when we land we test for death!
#
func jumping():
	if is_on_floor():
		current_state = State.WALK
		
func climbing():
	var animation_player = get_node("AnimationPlayer")
	var sprite = get_node("Sprite")
	motion.x = 0
	motion.y = 0
	
	if Input.is_action_pressed("ui_up") and is_on_ladder():
		var deltaX = active_ladders[0].global_position.x - sprite.global_position.x
		motion.x = deltaX*10
		motion.y = -CLIMB_VELOCITY
		animation_player.play("Climb")
	elif Input.is_action_pressed("ui_down") and is_on_ladder():
		var deltaX = active_ladders[0].global_position.x - sprite.global_position.x
		motion.x = deltaX*10
		motion.y = CLIMB_VELOCITY
		animation_player.play("Climb")
	elif is_on_floor() or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		current_state = State.WALK
		animation_player.play("Walk")		
	elif is_on_ladder():
		# give ability to pause on the ladder
		# motion.y is zero at this point
		animation_player.stop(false)

func dying(): 
	if is_on_floor():
		current_state = State.DEAD
		motion.x = 0
		motion.y = 0
		var animator = get_node("AnimationPlayer")
		animator.play("Death")
		yield(animator, "animation_finished")
		get_tree().reload_current_scene()


func is_on_ladder():
	return not active_ladders.empty()


func _ladder_status_changed(ladder_node, is_entry):
	if is_entry:
		active_ladders.append(ladder_node)
	else:
		active_ladders.erase(ladder_node)	

func _fred_is_dead():
	current_state = State.DYING
	get_node("Sprite").modulate = Color.pink
	GameState.life_lost()
