extends ItemIcon
class_name ArmorIcon

@export var protection: int
@export var armor: armor_type

enum armor_type {IRON_PLATE, STEEL_PLATE}

func _ready() -> void:
	stat_label.text = "+" + str(protection)
	item_label.text = armor_type.keys()[armor]
	item_label.text = item_label.text.capitalize()
