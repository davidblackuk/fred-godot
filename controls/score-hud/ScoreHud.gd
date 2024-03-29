
extends Node2D

export(String) var level_name = "??"

onready var game_time_label =  $GameTime/GameTimeValue
onready var level_time_label =  $LevelTime/LevelTimeValue

onready var level_record_label =  $LabelLevelRecord

onready var lives_label =  $Lives/LivesValue
onready var score_label =  $Score/ScoreValue

onready var level_name_label =  $LevelName

onready var god_mode_label = $Debug/LabelGodMode

onready var fps_label = $Debug/LabelFPS
onready var fps_value = $Debug/ValueFPS

onready var mem_label = $Debug/LabelMem
onready var mem_value = $Debug/ValueMem

var time_functions = TimeFunctions.new()

# we sweep up to this
var on_screen_score = 0

# how long since we last incremented the score
var total_delta_since_last_update = 0

# we increment the on screen score every this seconds
const score_update_period = 0.05

# we update the on screen score by this many every time to the GameManager.score value
const score_update_step = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# on level load, initialse the current score to the game score
	on_screen_score = GameManager.game_state.score
	level_name_label.text = level_name
	hide_stats_if_not_debug()
	show_if_god_mode()
	show_high_score()
	update()
	
# update the score on screen incrementing it until we reach the current game score
func _process(delta):
	total_delta_since_last_update += delta
	if (total_delta_since_last_update >= score_update_period):
		if (on_screen_score + score_update_step < GameManager.game_state.score):
			on_screen_score += score_update_step
		else:
			on_screen_score = GameManager.game_state.score
		total_delta_since_last_update = 0
		display_score()
		
	update_debug_info()
	update_ellapsed_time()
	
func update():
	display_score()
	display_lives()
	update_ellapsed_time()
	
func display_score():	
	score_label.text = "%05d" % on_screen_score
	
func display_lives():
	lives_label.text = "%03d" % GameManager.game_state.deaths
	
func hide_stats_if_not_debug():
	if (!GameManager.game_state.debug_mode):
		fps_label.hide()
		fps_value.hide()
		mem_label.hide()
		mem_value.hide()
		
func update_debug_info():
	var fps = Performance.get_monitor(Performance.TIME_FPS)
	var memory = Performance.get_monitor(Performance.MEMORY_STATIC) / 1024 / 1024
	fps_value.text = str(fps)
	mem_value.text = str(int(memory))

func update_ellapsed_time():
	game_time_label.text = GameManager.game_timer.as_string()
	level_time_label.text = GameManager.level_timer.as_string()
	
func show_high_score():
	var text = ""
	var score = GameManager.high_score_table.get_high_score_for_level(GameManager.game_state.current_level)
	if (score != null):
		var percentage = score[HighScoreTable.PERC_KEY]
		var dateFormat = "%d/%d/%d"
		var date = dateFormat % [
			score[HighScoreTable.WHEN_KEY]["day"],
			score[HighScoreTable.WHEN_KEY]["month"],
			score[HighScoreTable.WHEN_KEY]["year"]
		]
		var time = time_functions.msec_to_minutes_seconds(score[HighScoreTable.MSEC_KEY])
		var textFormat = "%d%% in %s on %s"
		text = textFormat % [percentage, time, date] if score != null else ""
	
	level_record_label.text = text

func show_if_god_mode():
	if (!GameManager.game_state.god_mode):
		god_mode_label.hide()
