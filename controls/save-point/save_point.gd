extends Area2D


@onready var particle: CPUParticles2D = $CPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

#
# Reshow the save point make opacity reset
# and the particle not emitting
#
func reshow() -> void:
	animation_player.play("RESET")
	particle.emitting = false


func _on_body_entered(player: Node2D) -> void:
	if player.name == "Player":
		GameManager.game_state.spawn_position = player.position

		particle.emitting = true
		animation_player.play("fade_out")
	

func _on_cpu_particles_2d_finished() -> void:
	hide()
