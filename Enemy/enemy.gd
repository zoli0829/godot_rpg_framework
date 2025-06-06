extends CharacterBody3D
class_name Enemy

const RUN_VELOCITY_THRESHOLD := 2.0

@export var max_health: float = 20.0
@export var xp_value: float = 25.0
@export var crit_rate: float = 0.05
@export var speed: float = 5.0

@onready var rig: Node3D = $Rig
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var player_detector: ShapeCast3D = $Rig/PlayerDetector
@onready var area_attack: ShapeCast3D = $Rig/AreaAttack
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

# Finds the player in the scene.
@onready var player: Player = get_tree().get_first_node_in_group("Player")

func _ready() -> void:
	rig.set_active_mesh(rig.villager_meshes.pick_random())
	health_component.update_max_health(max_health)

func _physics_process(delta: float) -> void:
	var velocity_target := Vector3.ZERO
	navigation_agent.target_position = player.global_position
	
	if rig.is_idle():
		check_for_attacks()
		if not navigation_agent.is_target_reached():
			velocity_target = get_local_navigation_direction() * speed
			orient_rig(navigation_agent.get_next_path_position())
	if not is_on_floor():
		velocity_target += get_gravity() * delta
	navigation_agent.velocity = velocity_target

func check_for_attacks() -> void:
	for collision_id in player_detector.get_collision_count():
		var collider = player_detector.get_collider(collision_id)
		if collider is Player:
			rig.travel("Overhead")
			navigation_agent.avoidance_mask = 0

func orient_rig(target_position: Vector3) -> void:
	target_position.y = rig.global_position.y
	if rig.global_position.is_equal_approx(target_position):
		return
	rig.look_at(target_position, Vector3.UP, true)

func get_local_navigation_direction() -> Vector3:
	var destination = navigation_agent.get_next_path_position()
	var local_destination = destination - global_position
	return local_destination.normalized()

func _on_health_component_defeat() -> void:
	player.stats.xp += xp_value
	rig.travel("Defeat")
	collision_shape_3d.disabled = true
	set_physics_process(false)

func _on_rig_heavy_attack() -> void:
	area_attack.deal_damage(20.0, crit_rate)
	navigation_agent.avoidance_mask = 1


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	if safe_velocity.length() > RUN_VELOCITY_THRESHOLD:
		rig.run_weight_target = 1.0
	else:
		rig.run_weight_target = 0.0
	
	velocity = safe_velocity
	move_and_slide()
