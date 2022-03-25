extends Node

const FIRST_LEVEL = "res://Levels/Level001/Level 001.tscn"

var game_timer = StopWatch.new()
var level_timer = StopWatch.new()
var game_state = GameState.new(FIRST_LEVEL)
var high_score_table = HighScoreTable.new()

var last_level_was_high_score = false
var last_level_msecs = 0
var last_level_percent = 0

func reset():
	game_state.reset(FIRST_LEVEL);
	game_timer.reset()
	level_timer.reset();

#
# Record an instance of freds frequent, but always heroic, deaths
#
func life_lost():
	game_state.deaths = game_state.deaths + 1

#
# Adds a value to the players score
#
func add_score(value):
	var new_score = game_state.score + value
	game_state.score = new_score


# ------------------------------------------------------------------------------
# LEVEL HANDLING

#
# level is complete, the next level's scene and the percentage of collectables
# collected is passed in for high score purposes
#
func level_complete(next_level, collectables_percent, from_cut_scene = false):
	game_timer.pause()
	level_timer.pause()
	last_level_msecs = level_timer.ellapsed_msec()
	last_level_percent = collectables_percent
	
	last_level_was_high_score = high_score_table.record_level_time(game_state.current_level, last_level_msecs, last_level_percent)

	last_level_was_high_score = (false if from_cut_scene else last_level_was_high_score)


	if next_level != null:
		game_state.current_level = next_level
		get_tree().change_scene(next_level)

#
# user has quit to the main menu, no need to test for high score etc
#
func level_quit():
	game_timer.pause()	
	last_level_was_high_score = false
	get_tree().change_scene("res://menus/main-menu.tscn")


func save():
	game_state.save()

func load():
	game_state.load()

