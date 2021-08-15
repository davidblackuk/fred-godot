#
# Keep track of fastest levels and complete run throughs for the game
#
class_name HighScoreTable

const MSEC_KEY = "msecs"
const PERC_KEY = "perc"

var _level_scores = {}

#
# Records the time taken to complete a level as a high score, if the time is lower
# than any existing time for that level. Only 100% complete levels (ie all items and victims)
# should be considered for high scores.
#
# returns true if the level time is a new record
#
func record_level_time(level_scene_name, time_msec, perc):
	var level_number = int(_get_level_number(level_scene_name))
	var res = false
	if (_level_scores.has(level_number) && _is_better_score(level_number, time_msec, perc)):
		_set_level_score(level_number, time_msec, perc)
		res = true
	else:
		_set_level_score(level_number, time_msec, perc)
		res = true
	
	print ("lvl: ", level_number, ", msec: ",  time_msec, ", perc: ", perc, "high score: ", res)
	return res

#
# Records the time taken for a complete run through of the game, completing 
# all levels and collecting all items. Returns true if this is a record run through
#
func record_game_time(levelSceneName, time_msec):
	return false

func _set_level_score(level_number, time_msec, percentage):
	_level_scores[level_number] = {
		MSEC_KEY: time_msec,
		PERC_KEY: percentage
	}

func  _is_better_score(level_number, time_msec, perc):
	pass

func _get_level_number(resource):
	return resource.replace("res://state/Level ","").replace(".tscn", "");
