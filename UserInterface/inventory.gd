extends Control

@onready var strength_value: Label = %StrengthValue
@onready var agility_value: Label = %AgilityValue
@onready var endurance_value: Label = %EnduranceValue
@onready var speed_value: Label = %SpeedValue
@onready var level_label: Label = %LevelLabel
@onready var attack_value: Label = %AttackValue

@onready var player: Player = get_parent().player

func _ready() -> void:
	update_stats()

func update_stats() -> void:
	# Update the attribute labels.
	strength_value.text = str(player.stats.strength.ability_score)
	agility_value.text = str(player.stats.agility.ability_score)
	endurance_value.text = str(player.stats.endurance.ability_score)
	speed_value.text = str(player.stats.speed.ability_score)
	# Update the level label.
	level_label.text = "Level %s" % player.stats.level

func update_gear_stats() -> void:
	attack_value.text = str(get_weapon_value())

func get_weapon_value() -> int:
	var damage = 10 
	damage += player.stats.get_damage_modifier()
	return damage


func _on_back_button_pressed() -> void:
	get_parent().close_menu()
