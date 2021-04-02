extends Node

const first_level = "res://Levels/Level 003.tscn"

var score  setget set_score, get_score
var deaths setget set_deaths, get_deaths
var current_level setget set_current_level, get_current_level

var debug_mode = false setget set_debug_mode, get_debug_mode
var god_mode = false setget set_god_mode, get_god_mode

var _game_state = GameState.new()

func reset():
	_game_state = GameState.new()
	_game_state.current_level = first_level

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






