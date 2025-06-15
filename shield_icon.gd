extends ItemIcon
class_name ShieldIcon

@export var protection: int
@export var item_model: PackedScene

func _ready() -> void:
	stat_label.text = "+" + str(protection)
	item_label.text = item_model.resource_path.get_file()
	var extension = item_model.resource_path.get_extension()
	item_label.text = item_label.text.rstrip("." + extension)
	item_label.text = item_label.text.capitalize()
