
extends Node2D

export(String) var level_name = "??"

onready var deaths_label =  $Deaths/DeathValue
onready var score_label =  $Score/ScoreValue
onready var level_name_label =  $LevelName

onready var fps_label = $Debug/LabelFPS
onready var fps_value = $Debug/ValueFPS
onready var mem_label = $Debug/LabelMem
onready var mem_value = $Debug/ValueMem


# we sweep up to this
var on_screen_score = 0

# how long since we last incremented the score
var total_delta_since_last_update = 0

# we increment the on screen score every this seconds
const score_update_period = 0.05

# we update the on screen score by this many every time to the GameStateManager.score value
const score_update_step = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# on level load, initialse the current score to the game score
	on_screen_score = GameStateManager.score
	level_name_label.text = level_name
	hide_stats_if_not_debug()
	update()
	
# update the score on screen incrementing it until we reach the current game score
func _process(delta):
	total_delta_since_last_update += delta
	if (total_delta_since_last_update >= score_update_period):
		if (on_screen_score + score_update_step < GameStateManager.score):
			on_screen_score += score_update_step
		else:
			on_screen_score = GameStateManager.score
		total_delta_since_last_update = 0
		display_score()
		
	update_debug_info()
	
func update():
	display_score()
	display_deaths()	
	
func display_score():	
	score_label.text = "%05d" % on_screen_score
	
func display_deaths():
	deaths_label.text = "%03d" % GameStateManager.deaths
	
func hide_stats_if_not_debug():
	if (!GameStateManager.debug_mode):
		fps_label.hide()
		fps_value.hide()
		mem_label.hide()
		mem_value.hide()
		
func update_debug_info():
	var fps = Performance.get_monitor(Performance.TIME_FPS)
	var memory = Performance.get_monitor(Performance.MEMORY_STATIC) / 1024 / 1024
	fps_value.text = str(fps)
	mem_value.text = str(int(memory))
