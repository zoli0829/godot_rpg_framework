extends Control

@onready var level_label: Label = %LevelLabel
@onready var health_bar: TextureProgressBar = %HealthBar
@onready var xp_bar: TextureProgressBar = %XPBar
@onready var health_label: Label = %HealthLabel
@onready var inventory: Control = $Inventory

@export var player: Player

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		if inventory.visible == false:
			open_menu()
		else:
			close_menu()

func update_stats_display() -> void:
	level_label.text = str(player.stats.level)
	xp_bar.max_value = player.stats.percentage_level_up_boundary()
	xp_bar.value = player.stats.xp
	inventory.update_stats()

func update_health() -> void:
	health_bar.max_value = player.health_component.max_health
	health_bar.value = player.health_component.current_health
	health_label.text = player.health_component.get_health_string()

func open_menu() -> void:
	inventory.visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	inventory.update_gear_stats()

func close_menu() -> void:
	inventory.visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
