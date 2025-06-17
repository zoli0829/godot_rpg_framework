extends StaticBody3D

func get_items() -> Array:
	return get_children().filter(func(child): return child is ItemIcon)

func _ready() -> void:
	print(get_items())
