extends Node2D

# Index of the selected trap
var __index: int
# String[]
var __traps: Array = []


func _init() -> void:
	__traps = EntityDb.get_all_trap_ids()
	select_trap(0)
	var _err = EntityDb.connect("register_trap", self, "_on_EntityDb_register_trap")

func select_trap(idx: int) -> void:
	if idx >= 0 and idx < __traps.size():
		__index = idx
		_log("Select trap %s" % __traps[idx])
	else:
		__index = -1 # Invalid value
		_log("Deselect trap")

func refresh_traps() -> void:
	_log("Refresh trap IDs")
	__traps = EntityDb.get_all_trap_ids()
	select_trap(__index)

# EntityDB singals

func _on_EntityDb_register_trap(_name: String):
	refresh_traps()

func _on_EntityDb_unregister_trap(_name: String):
	refresh_traps()

# InputHandler signals

func _on_InputHandler_place_trap():
	if __index == -1:
		return
	name = __traps[__index]
	if not EntityDb.has_trap_id(name):
		_log("Invalid trap name '%s'" % name)
		return
	var id = EntityDb.get_trap_id(name)
	_log("Build '%s (id: %s)'" % [name, id])

func _on_InputHandler_select_trap(index: int):
	select_trap(index)

func _on_InputHandler_select_next_trap():
	select_trap(__index + 1)

func _on_InputHandler_select_prev_trap():
	select_trap(__index - 1)

# Utility

func _log(msg: String) -> void:
	print("[Builder]: %s" % msg)
