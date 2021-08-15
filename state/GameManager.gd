extends Node


const FIRST_LEVEL = "res://Levels/Level 001.tscn"


# the game state instance


var game_timer = StopWatch.new()
var level_timer = StopWatch.new()
var game_state = GameState.new(FIRST_LEVEL);
var high_score_table = HighScoreTable.new()

var last_level_was_high_score = false

func reset():
	game_state.reset(FIRST_LEVEL);
	game_timer.reset()
	level_timer.reset();
	var x = game_timer.as_string()

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
func level_complete(next_level, collectables_percent):
	game_timer.pause()
	level_timer.pause()
	var levelTime = level_timer.ellapsed_msec()
	# check high score etc
	last_level_was_high_score = high_score_table.record_level_time(game_state.current_level, level_timer.ellapsed_msec(), collectables_percent)
	if next_level != null:
		get_tree().change_scene(next_level)

#
# user has quit to the main menu, no need to test for high score etc
#
func level_quit():
	game_timer.pause()	
	last_level_was_high_score = false
	get_tree().change_scene("res://menus/main-menu.tscn")
