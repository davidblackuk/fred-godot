extends Node

var score  setget set_score, get_score
var deaths setget set_deaths, get_deaths

var _score = 0;
var _deaths = 0

func get_score():
	return _score

func set_score(_value):
	push_error("do not set GameState.score directly: Use GameState.add_score() instead")

func add_score(value):
	_score += value
	print("Add to score ", value, " total: " , _score)

func get_deaths():
	return _deaths

func set_deaths(_value):
	push_error("do not set GameState.deaths directly: Use GameState.life_lost() instead")

func life_lost():
	_deaths += 1

