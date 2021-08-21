#
# Keep track of fastest levels and complete run throughs for the game
#
class_name HighScoreTable

const MSEC_KEY = "msecs"
const PERC_KEY = "perc"

# these should go in game_state
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
	
	# we dont show a high score on a first play through of a level, that would be boring
	var had_previous_score = _has_previous_score_recorded(level_number)
	if (_is_better_score(level_number, time_msec, perc)):
		_set_level_score(level_number, time_msec, perc)
		res = had_previous_score	
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
#
# Do the current stats, top any existing stats for this level
#
func  _is_better_score(level_number, time_msec, perc):
	# no recorded score means this is top trump
	if !_has_previous_score_recorded(level_number):
		return true
	var current = _level_scores[level_number]	
	# better percentage is beats any time regardless
	if (perc > current[PERC_KEY]):
		return true
	else: # finally a lower time wins
		return time_msec < current[MSEC_KEY] 

func _has_previous_score_recorded(level_number):
	return _level_scores.has(level_number)
#
# extract the level number from the resource
#
func _get_level_number(resource):
	return resource.replace("res://state/Level ","").replace(".tscn", "");
