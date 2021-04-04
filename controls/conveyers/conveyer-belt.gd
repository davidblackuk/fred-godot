extends Node2D

signal conveyer_status_changed(conveyer_node, is_entry)

func _on_player_detection_area_body_entered(body):
	if body.name == "Player":
		emit_signal("conveyer_status_changed", self, true)

func _on_player_detection_area_body_exited(body):
	if body.name == "Player":
		emit_signal("conveyer_status_changed", self, false)
