extends CenterContainer

func _ready() -> void:
	visible = false

func close() -> void:
	visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func open() -> void:
	if visible:
		close()
	else:
		visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
