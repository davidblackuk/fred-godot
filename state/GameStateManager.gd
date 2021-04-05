extends Node

const SAVE_FILE_PATH = "user://game-save.dat"
const FIRST_LEVEL = "res://Levels/Level 001.tscn"


var score  setget set_score, get_score
var deaths setget set_deaths, get_deaths
var current_level setget set_current_level, get_current_level

var debug_mode = false setget set_debug_mode, get_debug_mode
var god_mode = false setget set_god_mode, get_god_mode

var _game_state = GameState.new()

func reset():
	_game_state = GameState.new()
	_game_state.current_level = FIRST_LEVEL

func get_score():
	return _game_state.score

func set_score(_value):
	push_error("do not set GameStateManager.score directly: Use GameStateManager.add_score() instead")

func add_score(value):
	_game_state.score += value
	print("Add to score ", value, " total: " , _game_state.score)

func get_deaths():
	return _game_state.deaths

func set_deaths(_value):
	push_error("do not set GameStateManager.deaths directly: Use GameStateManager.life_lost() instead")

func life_lost():
	_game_state.deaths += 1

func set_current_level(value):
	_game_state.current_level = value
	
func get_current_level():
	return _game_state.current_level

func set_debug_mode(value):
	_game_state.debug_mode = value
	
func get_debug_mode():
	return _game_state.debug_mode

func set_god_mode(value):
	_game_state.god_mode = value
	
func get_god_mode():
	return _game_state.god_mode






func save_file_exists():
	var file = File.new()
	return file.file_exists(SAVE_FILE_PATH)

func save():
	var file = File.new()
	var error = file.open(SAVE_FILE_PATH, File.WRITE)
	if error == OK:
		file.store_var(_game_state)
		file.close()
	else:
		print("File open for save state failed, error code: ", error)

func load():
	if save_file_exists():
		var file = File.new()
		var error = file.open(SAVE_FILE_PATH, File.READ)
		if error == OK:
			var data = file.get_var()
			print(data)
			file.close()
			_game_state = data
		else:
			print("File open for read state failed, error code: ", error)
		
		

