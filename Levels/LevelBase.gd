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

func _ready():
	GameStateManager.game_state.current_level = get_tree().current_scene.filename
	fader.fade_in()
	count_victims()
	connect_spikes_to_player()
	connect_ladders_to_player()
	connect_conveyors_to_player()
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_home")):
		next_scene = "res://menus/main-menu.tscn"
		fader.fade_out()
	if (Input.is_action_just_pressed("ui_end") && GameStateManager.game_state.debug_mode):
		emit_signal("level_complete")
	
func count_victims():
	total_victims = victims.get_child_count() if victims != null else 0

func _on_victim_rescued():
	rescued_victims = rescued_victims + 1
	if rescued_victims == total_victims:
		emit_signal("level_complete")

func _on_item_collected(reward):
	GameStateManager.add_score(reward)
	collected_items += 1

func connect_coins_to_self():
	get_tree().call_group("Collectables", "connect", "item_collected", self, "_on_item_collected")

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

#
# We go to the next scene, if set. The next scene is defined as
# a property of the root node. Fairly simple. Last level, currently
# redirects to the main menu, though we really should do a game over
# congratulations type scene when we have a fuller set of levels
#
func goto_next_scene():
	if next_scene != null:
		GameStateManager.level_complete(next_scene, 1 if total_items == 0  else collected_items / total_items )

