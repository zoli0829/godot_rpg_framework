extends Control

@onready var level_label: Label = %LevelLabel

@export var player: Player

func update_stats_display() -> void:
	level_label.text = str(player.stats.level)
