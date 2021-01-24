extends Node


signal selected_trap_index_changed(index)
# Index into available_traps or -1
var selected_trap_index: int = -1 setget _set_selected_trap_index

signal available_traps_changed()
# String[]: Names of the traps
# Please don't modify this array manually, use the provided methods:
# - 'add_available_trap'
# - 'remove_available_trap'
# Re-assignment is ok.
var available_traps: Array setget _set_available_traps

func add_available_trap(name: String) -> void:
    available_traps.push_back(name)
    emit_signal("available_traps_changed")

func remove_available_trap(idx: int) -> void:
    available_traps.remove(idx)
    emit_signal("available_traps_changed")

# Setters and getters

func _set_selected_trap_index(idx: int) -> void:
    selected_trap_index = idx
    _log("Emit 'selected_trap_index_changed'")
    emit_signal("selected_trap_index_changed", idx)

func _set_available_traps(traps: Array) -> void:
    available_traps = traps
    _log("Emit 'available_traps_changed'")
    emit_signal("available_traps_changed")

# Utility
func _log(msg: String) -> void:
    print("[BuildPhaseState]: %s" % msg)
