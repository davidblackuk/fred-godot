class_name GameState


# Dictionary keys for state values
const SCORE_KEY = "score"
const DEATHS_KEY = "deaths"
const CURRENT_LEVEL_KEY = "current_level"
const DEBUG_MODE_KEY = "debug_mode"
const GOD_MODE_KEY = "god_mode"

var _game_state = { }

# settter getters to encapsulate the dictionary
var score : get = get_score, set = set_score
var deaths : get = get_deaths, set = set_deaths
var current_level : get = get_current_level, set = set_current_level
var debug_mode = false: get = get_debug_mode, set = set_debug_mode
var god_mode = false: get = get_god_mode, set = set_god_mode

func _init(first_level):
	reset(first_level)
	
func reset(first_level):
	_game_state = {
		SCORE_KEY: 0,
		DEATHS_KEY: 0, 
		CURRENT_LEVEL_KEY: first_level, 
		DEBUG_MODE_KEY: true, 
		GOD_MODE_KEY: false, 
	}	
	


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
	
	

# ----------------
# Persistance code
# todo: seperate class please
# ----------------

const SAVE_FILE_PATH = "user://game-save.dat"
#
# Tests if a save file exists for the game
#
func save_file_exists():
	return FileAccess.file_exists(SAVE_FILE_PATH)

#
# Saves the current game state to disk
#
func save():
	var file:FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	
	if file != null:
		file.store_var(_game_state)
		file.close()
	else:
		print("File open for save state failed, error code: ", FileAccess.get_open_error())

#
# Loads the game state from disk and sets it as the current state.
#
func load():
	if save_file_exists():
		var file: FileAccess = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
		if file != null:
			var data = file.get_var()
			print("Load state: ", data)
			file.close()
			_game_state = data
		else:
			print("File open for read state failed, error code: ", FileAccess.get_open_error())
	
	
	
