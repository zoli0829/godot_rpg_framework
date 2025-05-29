extends Node3D

@export var player: Player
@export var speed_multiplier: float = 3.0

@onready var timer: Timer = $Timer
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D

var direction := Vector3.ZERO
var dash_duration := 0.1
var time_remaining := 0.0

func _unhandled_input(event: InputEvent) -> void:
	if not timer.is_stopped():
		return
		
	if not player.is_physics_processing():
		return
	
	if event.is_action_pressed("dash"):
		direction = player.get_movement_direction()
		
		if not direction.is_zero_approx():
			player.rig.travel("Dash")
			gpu_particles_3d.emitting = true
			timer.start(player.stats.get_dash_cooldown())
			time_remaining = dash_duration

func _physics_process(delta: float) -> void:
	if direction.is_zero_approx():
		return
	player.velocity = direction * player.stats.get_base_speed() * speed_multiplier
	time_remaining -= delta
	if time_remaining <= 0:
		direction = Vector3.ZERO
		gpu_particles_3d.emitting = false
