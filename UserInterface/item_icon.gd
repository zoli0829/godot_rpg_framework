extends TextureButton
class_name ItemIcon

signal interact(item)

@onready var stat_label: Label = $MarginContainer/StatLabel
@onready var item_label: Label = $MarginContainer/ItemLabel


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action("attack"):
		interact.emit(self)
