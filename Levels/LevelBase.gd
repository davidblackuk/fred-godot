extends Node2D

var total_victims = 0
var rescued_victims = 0

var total_items = 0.0
var collected_items = 0.0

export(String, FILE, "*.tscn") var next_scene

signal level_complete()

onready var player = get_node("Player")
onready var victims = get_node_or_null("Victims")
onready var fader = get_node("Fader")
onready var collectables = get_node_or_null("Collectables")

var exit_is_to_menu = false

func _ready():
	GameManager.level_timer.pause()
	GameManager.game_state.current_level = get_tree().current_scene.filename
	count_victims()
	count_collectables()
	connect_spikes_to_player()
	connect_ladders_to_player()
	connect_enemies_to_player()
	connect_conveyors_to_player()
	connect_coins_to_self()
	connect_fader_to_self()
	fader.fade_in()
	# if fading in pause the game to allow high scores to be shown
	get_tree().paused = true
		
	
func _process(_delta):
	if (Input.is_action_just_pressed("ui_home")):		
		exit_is_to_menu = true
		fader.fade_out()
	if (Input.is_action_just_pressed("ui_end") && GameManager.game_state.debug_mode):
		emit_signal("level_complete")
	
func count_victims():
	total_victims = victims.get_child_count() if victims != null else 0
	
func count_collectables():
	total_items = collectables.get_child_count() if collectables != null else 0
	

func _on_victim_rescued():
	rescued_victims = rescued_victims + 1
	if rescued_victims == total_victims:
		emit_signal("level_complete")

func _on_item_collected(reward):
	GameManager.add_score(reward)
	collected_items += 1

func connect_coins_to_self():
	get_tree().call_group("Collectables", "connect", "item_collected", self, "_on_item_collected")


func connect_enemies_to_player():
	get_tree().call_group("Enemies", "connect", "fred_is_dead", player, "_fred_is_dead")

#
# Get the members of the spikes group and attach the player_hit_spike() signal to
# the players _fred_is_dead() function. Death on contact ensues
#
func connect_spikes_to_player():
	get_tree().call_group("Spikes", "connect", "player_hit_spike", player, "_fred_is_dead")

#
# Get the members of the ladders group and attach the ladder_status_changed() signal to
# the players _ladder_status_changed() function. This enables climbing ladders
#
func connect_ladders_to_player():
	get_tree().call_group("Ladders", "connect", "ladder_status_changed", player, "_ladder_status_changed")

#
# Get the members of the conveyers group and attach the conveyer_status_changed() signal to
# the players _conveyer_status_changed() function. This enables convyers
#
func connect_conveyors_to_player():
	get_tree().call_group("Conveyors", "connect", "conveyor_status_changed", player, "_conveyor_status_changed")

func connect_fader_to_self():
	fader.connect("fade_out_complete", self, "_on_fader_fade_out_complete")
	fader.connect("fade_in_complete", self, "_on_fader_fade_in_complete")

#
# the player has entered the door and is going to proceed to 
# the next level after we fade the scene out 
#
func _player_entered_door():
	fader.fade_out()

#
# The scene has faded out, we go to the next scene
#
func _on_fader_fade_out_complete():
	goto_next_scene()
	
func _on_fader_fade_in_complete():
	GameManager.last_level_was_high_score = false
	GameManager.level_timer.reset()
	GameManager.game_timer.continue()
	get_tree().paused = false

#
# We go to the next scene, if set. The next scene is defined as
# a property of the root node. Fairly simple. Last level, currently
# redirects to the main menu, though we really should do a game over
# congratulations type scene when we have a fuller set of levels
#
func goto_next_scene():
	if exit_is_to_menu:
		GameManager.level_quit()
	elif next_scene != null:
		var perc =  100 if total_items == 0  else int((float(collected_items) / float(total_items)*100))
		GameManager.level_complete(next_scene, perc)

