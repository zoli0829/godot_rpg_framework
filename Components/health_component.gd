extends Node
class_name HealthComponent

signal defeat()
signal health_changed()

var max_health: float
var current_health: float:
	set(value):
		current_health = max(value, 0.0)
		if current_health == 0.0:
			defeat.emit()
		health_changed.emit()


func update_max_health(max_hp_in: float) -> void:
	max_health = max_hp_in
	current_health = max_health


func take_damage(damage_in: float) -> void:
	current_health -= damage_in
