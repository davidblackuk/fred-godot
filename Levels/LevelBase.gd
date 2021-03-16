extends Node2D

var total_victims = 0
var rescued_victims = 0

signal level_complete()

func _ready():
	count_victims()
	
	
func count_victims():
	var allVictims = get_node_or_null("Victims")
	if allVictims:
		total_victims = allVictims.get_child_count()
	print("Number of victims found: ", total_victims, name)
	


func _on_victim_rescued():
	rescued_victims = rescued_victims + 1
	if rescued_victims == total_victims:
		emit_signal("level_complete")


