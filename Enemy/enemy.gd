extends CharacterBody3D
class_name Enemy

@export var max_health: float = 20.0

@onready var rig: Node3D = $Rig
@onready var health_component: HealthComponent = $HealthComponent
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var player_detector: ShapeCast3D = $Rig/PlayerDetector
@onready var area_attack: ShapeCast3D = $Rig/AreaAttack


func _ready() -> void:
	rig.set_active_mesh(rig.villager_meshes.pick_random())
	health_component.update_max_health(max_health)


func _physics_process(delta: float) -> void:
	if rig.is_idle():
		check_for_attacks()


func check_for_attacks() -> void:
	for collision_id in player_detector.get_collision_count():
		var collider = player_detector.get_collider(collision_id)
		if collider is Player:
			rig.travel("Overhead")


func _on_health_component_defeat() -> void:
	rig.travel("Defeat")
	collision_shape_3d.disabled = true
	set_physics_process(false)


func _on_rig_heavy_attack() -> void:
	area_attack.deal_damage(20.0)
