extends Node

const SAVE_FILE_PATH = "user://game-save.dat"
const FIRST_LEVEL = "res://Levels/Level 001.tscn"

# Dictionary keys for state values
const SCORE_KEY = "score"
const DEATHS_KEY = "deaths"
const CURRENT_LEVEL_KEY = "current_level"
const DEBUG_MODE_KEY = "debug_mode"
const GOD_MODE_KEY = "god_mode"

# settter getters to encapsulate the dictionary
var score  setget set_score, get_score
var deaths setget set_deaths, get_deaths
var current_level setget set_current_level, get_current_level
var debug_mode = false setget set_debug_mode, get_debug_mode
var god_mode = false setget set_god_mode, get_god_mode

# the game state instance
var _game_state = { }

#
# Resets the state to default values, while this could be just an empty 
# dictionary, this is more explicit
#
func reset():
	_game_state = {
		SCORE_KEY: 0,
		DEATHS_KEY: 0, 
		CURRENT_LEVEL_KEY: FIRST_LEVEL, 
		DEBUG_MODE_KEY: false, 
		GOD_MODE_KEY: false, 
	}	
	_game_state.current_level = FIRST_LEVEL

#
# gets the score if present or returns 0 if not
#
func get_score():
	return _game_state[SCORE_KEY] if SCORE_KEY in _game_state else 0

#
# protects the score from direct modification by throwing an error, please use
# add score to do this.
#
func set_score(_value):
	push_error("do not set GameStateManager.score directly: Use GameStateManager.add_score() instead")

#
# Adds a value to the players score
#
func add_score(value):
	var new_score = get_score() + value
	_game_state[SCORE_KEY] = new_score
	print("Add to score ", value, " total: " , _game_state[SCORE_KEY])

#
# returns the death count for the player
#
func get_deaths():
	return _game_state[DEATHS_KEY] if DEATHS_KEY in _game_state else 0

#
# guards against direct modifications to the death count. Plase use life_lost
# to do this
#
func set_deaths(_value):
	push_error("do not set GameStateManager.deaths directly: Use GameStateManager.life_lost() instead")

#
# Record an instance of freds frequent, but always heroic, deaths
#
func life_lost():
	_game_state[DEATHS_KEY] = _game_state[DEATHS_KEY] + 1

#
# sets the resource file name of current level
#
func set_current_level(value):
	_game_state[CURRENT_LEVEL_KEY] = value

#
# gets the resource file name of current level
#
func get_current_level():
	return _game_state[CURRENT_LEVEL_KEY] if DEATHS_KEY in _game_state else null

#
# Sets a flag indicating debug mode is enabled. This shows various stats in the game
#
func set_debug_mode(value):
	_game_state[DEBUG_MODE_KEY] = value
	
#
# Returns a flag indicating debug mode is enabled. This shows various stats in the game
#
func get_debug_mode():
	return _game_state[DEBUG_MODE_KEY]  if DEBUG_MODE_KEY in _game_state else false

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
	return _game_state[GOD_MODE_KEY]  if GOD_MODE_KEY in _game_state else false



#
# Persistance code
#

#
# Tests if a save file exists for the game
#
func save_file_exists():
	var file = File.new()
	return file.file_exists(SAVE_FILE_PATH)

#
# Saves the current game state to disk
#
func save():
	var file = File.new()
	var error = file.open(SAVE_FILE_PATH, File.WRITE)
	if error == OK:
		file.store_var(_game_state)
		file.close()
	else:
		print("File open for save state failed, error code: ", error)

#
# Loads the game state from disk and sets it as the current state.
#
func load():
	if save_file_exists():
		var file = File.new()
		var error = file.open(SAVE_FILE_PATH, File.READ)
		if error == OK:
			var data = file.get_var()
			print("Load state: ", data)
			file.close()
			_game_state = data
		else:
			print("File open for read state failed, error code: ", error)
