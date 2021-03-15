extends Node2D

onready var deathsLabel =  get_node("Deaths/DeathValue")
onready var scoreLabel =  get_node("Score/ScoreValue")

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_hud()	



func _update_hud():
	display_score()
	display_deaths()	
	

func display_score():
	scoreLabel.text = "%05d" % GameState.score
	
func display_deaths():
	deathsLabel.text = "%03d" % GameState.deaths
	
