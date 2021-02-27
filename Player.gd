extends KinematicBody2D

const PLATFORM_COLLISION_BIT = 1
const HORIZONTAL_VELOCITY = 150
const JUMP_VELOCITY = 320
const GRAVITY = 10

var motion = Vector2()
var is_jumping = false

signal level_complete()


func _physics_process(delta):

	process_input()
				
	motion = move_and_slide(motion, Vector2.UP)

func process_input():
	motion.y += GRAVITY
	
	var animation_player = get_node("AnimationPlayer")
	var sprite = get_node("Sprite")
	
	if Input.is_action_pressed("ui_left"):
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
		
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		motion.y = -JUMP_VELOCITY
		is_jumping = true

	if Input.is_action_just_pressed("ui_home"):
		emit_signal("level_complete")



func _on_ladder_available(ladder_node):
	print("Ladder: " + ladder_node.name)



