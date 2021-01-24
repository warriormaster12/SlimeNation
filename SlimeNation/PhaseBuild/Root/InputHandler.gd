extends Node2D


signal place_trap(x, y)
signal select_trap(index)
signal select_next_trap()
signal select_prev_trap()
signal toggle_build_menu()

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("game_build_place"):
		_log("Emit place_trap")
		var pos = get_viewport().get_mouse_position();
		emit_signal("place_trap", pos.x, pos.y)
	elif event.is_action_released("game_build_select_next_trap"):
		# Must use released event for scroll wheel
		_log("Emit select_next_trap")
		emit_signal("select_next_trap")
	elif event.is_action_released("game_build_select_prev_trap"):
		# Must use released event for scroll wheel
		_log("Emit select_prev_trap")
		emit_signal("select_prev_trap")
	elif event.is_action_pressed("game_build_select_trap_1"):
		_log("Emit select_trap 0")
		emit_signal("select_trap", 0)
	elif event.is_action_pressed("game_build_select_trap_2"):
		_log("Emit select_trap 1")
		emit_signal("select_trap", 1)
	elif event.is_action_pressed("game_build_select_trap_3"):
		_log("Emit select_trap 2")
		emit_signal("select_trap", 2)
	elif event.is_action_pressed("game_build_select_trap_4"):
		_log("Emit select_trap 3")
		emit_signal("select_trap", 3)
	elif event.is_action_pressed("game_build_select_trap_5"):
		_log("Emit select_trap 4")
		emit_signal("select_trap", 4)
	elif event.is_action_pressed("game_build_menu_toggle"):
		_log("Emit toggle_build_menu")
		emit_signal("toggle_build_menu")
	elif event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_T:
			_log("Register new trap 'New' with id '10'")
			EntityDb.register_trap_id("New", 10)

# Utility

func _log(msg: String) -> void:
	print("[Input]: %s" % msg)
