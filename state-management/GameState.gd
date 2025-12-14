class_name GameState


# Dictionary keys for state values
const SCORE_KEY = "score"
const DEATHS_KEY = "deaths"
const CURRENT_LEVEL_KEY = "current_level"
const DEBUG_MODE_KEY = "debug_mode"
const GOD_MODE_KEY = "god_mode"
const FRED_SPAWN_POSITION = "fred_spawn_position"

var _game_state = { }

# settter getters to encapsulate the dictionary
var score : get = get_score, set = set_score
var deaths : get = get_deaths, set = set_deaths
var current_level : get = get_current_level, set = set_current_level
var debug_mode = false: get = get_debug_mode, set = set_debug_mode
var god_mode = false: get = get_god_mode, set = set_god_mode
var spawn_position = Vector2.ZERO : get = get_spawn_position, set = set_spawn_position



func _init(first_level):
	reset(first_level)
	
func reset(first_level):
	_game_state = {
		SCORE_KEY: 0,
		DEATHS_KEY: 0, 
		CURRENT_LEVEL_KEY: first_level, 
		DEBUG_MODE_KEY: true, 
		GOD_MODE_KEY: false, 
		FRED_SPAWN_POSITION: Vector2.ZERO
	}	
	

func get_spawn_position (): 
	return Vector2(_game_state[FRED_SPAWN_POSITION].x, _game_state[FRED_SPAWN_POSITION].y)

func set_spawn_position (value: Vector2):
	_game_state[FRED_SPAWN_POSITION] = Vector2(value.x, value.y)


func get_score():
	return _game_state[SCORE_KEY]

func set_score(value):
	_game_state[SCORE_KEY] = value

#
# returns the death count for the player
#
func get_deaths():
	return _game_state[DEATHS_KEY]

func set_deaths(value):
	_game_state[DEATHS_KEY] = value

#
# sets the resource file name of current level
#
func set_current_level(value):
	_game_state[CURRENT_LEVEL_KEY] = value

#
# gets the resource file name of current level
#
func get_current_level():
	return _game_state[CURRENT_LEVEL_KEY]

#
# Sets a flag indicating debug mode is enabled. This shows various stats in the game
#
func set_debug_mode(value):
	_game_state[DEBUG_MODE_KEY] = value
	
#
# Returns a flag indicating debug mode is enabled. This shows various stats in the game
#
func get_debug_mode():
	return _game_state[DEBUG_MODE_KEY]

#
# Sets a flag indicating god mode is enabled. In this mode fred cannot die. makes 
# testing of the game easier 
#
func set_god_mode(value):
	_game_state[GOD_MODE_KEY] = value

#
# Retruns a flag indicating god mode is enabled. In this mode fred cannot die. makes 
# testing of the game easier 
#
func get_god_mode():
	return _game_state[GOD_MODE_KEY]
	
	

	
	
