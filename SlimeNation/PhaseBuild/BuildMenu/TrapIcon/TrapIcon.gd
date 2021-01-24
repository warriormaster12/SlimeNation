class_name TrapIcon
extends Control

signal pressed

var _selected: bool setget select, is_selected
export (Color) var _normal_color
export (Color) var _selected_color

func _ready():
	select(false)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			emit_signal("pressed")
			accept_event()

func set_text(text: String) -> void:
	print("[Icon]: Set text '%s'" % text)
	$Margin/VBox/Name.text = text

func set_icon(path: String) -> void:
	print("[Icon]: Set icon '%s'" % path)
	$Margin/VBox/Icon.texture = load(path)

func select(selected: bool) -> void:
	_selected = selected
	if selected:
		$ColorRect.color = _selected_color
	else:
		$ColorRect.color = _normal_color

func is_selected() -> bool:
	return _selected
