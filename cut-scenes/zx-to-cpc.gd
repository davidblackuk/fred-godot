extends Node2D

@export var next_scene # (String, FILE, "*.tscn")

@onready var door = $Door
@onready var fader = get_node("Fader")

# Called when the node enters the scene tree for the first time.
func _ready():
	# will need to decide how we tranmsit into and oput of these cut scenes
	# and how that interacts with the timers for high score
	#
	# GameManager.last_level_was_high_score = false
	connect_fader_to_self()
	fader.fade_in()
	door._level_complete()
	get_tree().paused = true


func on_enter_next_level():
	print("Begin CPC") 
	fader.fade_out()


func connect_fader_to_self():
	fader.connect("fade_out_complete", Callable(self, "_on_fader_fade_out_complete"))
	fader.connect("fade_in_complete", Callable(self, "_on_fader_fade_in_complete"))
	
	
	
func _on_fader_fade_out_complete():
	GameManager.level_complete(next_scene, 0, true)
	
func _on_fader_fade_in_complete():
	GameManager.last_level_was_high_score = false
	get_tree().paused = false
