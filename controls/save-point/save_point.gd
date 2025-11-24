extends Area2D


@onready var particle: CPUParticles2D = $CPUParticles2D




func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		particle.emitting = true
		#queue_free()
