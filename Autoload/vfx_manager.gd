extends Node3D

const DAMAGE_NUMBER = preload("res://Components/damage_number.tscn")

func spawn_damage_number(damage: int, color: Color, position_in: Vector3) -> void:
	var new_number = DAMAGE_NUMBER.instantiate()
	new_number.setup(damage, color, position_in)
	add_child(new_number)
