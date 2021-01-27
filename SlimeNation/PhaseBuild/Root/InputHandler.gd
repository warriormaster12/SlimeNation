extends Node2D


signal place_trap()
signal rotate_trap()
signal select_trap(index)
signal select_next_trap()
signal select_prev_trap()
signal toggle_build_menu()


func _unhandled_input(event):
	if event.is_action_pressed("game_build_place"):
		_log("Emit place_trap")
		emit_signal("place_trap")
	elif event.is_action_pressed("game_build_rotate_trap"):
		_log("Emit rotate_trap")
		emit_signal("rotate_trap")
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

# Utility

func _log(msg: String) -> void:
	print("[Input]: %s" % msg)
