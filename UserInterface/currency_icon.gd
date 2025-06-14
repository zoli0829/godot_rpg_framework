extends ItemIcon

@export var value: int

func _ready() -> void:
	stat_label.text = "+" + str(value)
