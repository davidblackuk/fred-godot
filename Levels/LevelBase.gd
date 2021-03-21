extends Node2D

var total_victims = 0
var rescued_victims = 0

signal level_complete()

onready var player = get_node("Player")
onready var victims = get_node_or_null("Victims")

func _ready():
	count_victims()
	
	
func count_victims():
	total_victims = victims.get_child_count() if victims != null else 0

func _on_victim_rescued():
	rescued_victims = rescued_victims + 1
	if rescued_victims == total_victims:
		emit_signal("level_complete")

var level_names = ["","",""]
