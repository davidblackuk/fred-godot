extends Node2D

onready var deathsLabel =  get_node("Deaths/DeathValue")
onready var scoreLabel =  get_node("Score/ScoreValue")

# we sweep up to this
var on_screen_score = 0

# how long since we last incremented the score
var total_delta_since_last_update = 0

# we increment the on screen score every this seconds
const score_update_period = 0.05

# we update the on screen score by this many every time to the GameState.score value
const score_update_step = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	# on level load, initialse the current score to the game score
	on_screen_score = GameState.score
	update()
	
# update the score on screen incrementing it until we reach the current game score
func _process(delta):
	total_delta_since_last_update += delta
	if (total_delta_since_last_update >= score_update_period):
		if (on_screen_score + score_update_step < GameState.score):
			on_screen_score += score_update_step
		else:
			on_screen_score = GameState.score
		total_delta_since_last_update = 0
		display_score()
	
func update():
	display_score()
	display_deaths()	
	

func display_score():	
	scoreLabel.text = "%05d" % on_screen_score
	
func display_deaths():
	deathsLabel.text = "%03d" % GameState.deaths
	
