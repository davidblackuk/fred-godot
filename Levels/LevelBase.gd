extends Node2D

var total_victims = 0
var rescued_victims = 0

signal level_complete()

onready var player = get_node("Player")
onready var victims = get_node_or_null("Victims")

func _ready():
	count_victims()
	connect_spikes_to_player()
	
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
