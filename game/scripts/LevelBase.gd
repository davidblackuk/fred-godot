extends Node2D

var total_victims = 0
var rescued_victims = 0

var total_items = 0.0
var collected_items = 0.0

#@export var next_scene # (String, FILE, "*.tscn")

@export_file("*.tscn") var next_scene: String
signal level_complete()

@onready var player = get_node("Player")
@onready var victims = get_node_or_null("Victims")
@onready var fader = get_node("Fader")
@onready var collectables = get_node_or_null("Collectables")

var exit_is_to_menu = false

func _ready():
	GameManager.level_timer.pause()
	GameManager.game_state.current_level = get_tree().current_scene.scene_file_path

	if GameManager.game_state.spawn_position == Vector2.ZERO:
		GameManager.game_state.spawn_position = player.position
	else:
		player.position = GameManager.game_state.spawn_position
		# remove victims aleared collected + coins collected
		
	count_victims()
	count_collectables()
	connect_enemies_to_player()
	connect_coins_to_self()
	connect_fader_to_self()
	print("total-victims: " + str(total_victims))
	print("total-collectables: " + str(total_items))
	
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


func connect_coins_to_self():
#	get_tree().get_nodes_in_group("Collectables").map(func(coin): if coin.has_signal("item_collected"): coin.connect("item_collected", Callable(self, "_on_item_collected")))
	print("Connect coins to player...")
	var nodes :Array= get_tree().get_nodes_in_group("Collectables")
	nodes.map(func(e): if e.has_signal("item_collected"): e.connect("item_collected", Callable(self, "_on_item_collected")))
	print("Connected " + str(nodes.size()) + " enemies to freds _fred_is_dead function")



func connect_enemies_to_player():
	print("Connect enemies to player...")
	var nodes :Array= get_tree().get_nodes_in_group("Enemies")
	nodes.map(func(e): if e.has_signal("fred_is_dead"): e.connect("fred_is_dead", Callable(player, "_fred_is_dead")))
	print("Connected " + str(nodes.size()) + " enemies to freds _fred_is_dead function")
#

func connect_fader_to_self():
	fader.connect("fade_out_complete", Callable(self, "_on_fader_fade_out_complete"))
	fader.connect("fade_in_complete", Callable(self, "_on_fader_fade_in_complete"))

# An item (coins only at the moment) has been collected
func _on_item_collected(reward):
	GameManager.add_score(reward)
	collected_items += 1



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
	GameManager.game_timer.cont()
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
