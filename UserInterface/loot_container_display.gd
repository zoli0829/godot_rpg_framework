extends CenterContainer

@export var inventory: Inventory

@onready var grid_container: GridContainer = $PanelContainer/VBoxContainer/GridContainer
@onready var title_label: Label = $PanelContainer/VBoxContainer/TitleTexture/TitleLabel

var current_container: LootContainer

func _ready() -> void:
	visible = false

func close() -> void:
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if is_instance_valid(current_container):
		for item in grid_container.get_children():
			item.interact.disconnect(pickup_item)
			grid_container.remove_child(item)
			current_container.add_child(item)
			item.visible = false

func open(loot: LootContainer) -> void:
	if visible:
		close()
	else:
		current_container = loot
		title_label.text = loot.name.capitalize()
		for item in loot.get_items():
			current_container.remove_child(item)
			grid_container.add_child(item)
			item.visible = true
			item.interact.connect(pickup_item)
		visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func pickup_item(icon: ItemIcon) -> void:
	icon.interact.disconnect(pickup_item)
	if icon is CurrencyIcon:
		inventory.add_currency(icon.value)
		icon.queue_free()
	else:
		inventory.add_item(icon)
