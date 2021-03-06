extends Node2D

var total_victims = 0
var rescued_victims = 0

export(String, FILE, "*.tscn") var next_scene

signal level_complete()

onready var player = get_node("Player")
onready var victims = get_node_or_null("Victims")
onready var fader = get_node("Fader")

func _ready():
	GameStateManager.current_level = get_tree().current_scene.filename
	fader.fade_in()
	count_victims()
	connect_spikes_to_player()
	connect_ladders_to_player()
	connect_conveyors_to_player()
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_home")):
		next_scene = "res://menus/main-menu.tscn"
		fader.fade_out()
	if (Input.is_action_just_pressed("ui_end") && GameStateManager.debug_mode):
		emit_signal("level_complete")
	
func count_victims():
	total_victims = victims.get_child_count() if victims != null else 0

func _on_victim_rescued():
	rescued_victims = rescued_victims + 1
	if rescued_victims == total_victims:
		emit_signal("level_complete")

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


func _on_fader_fade_out_complete():
	goto_next_scene()

func goto_next_scene():
	if next_scene != null:
		get_tree().change_scene(next_scene)

func _player_entered_door():
	fader.fade_out()
