extends Node2D

# Index of the selected trap
var __index: int = -1 setget _set_index, _get_index
# String[]
var __traps: Array = [] setget _set_traps, _get_traps


func _init() -> void:
    __index = 0
    refresh_traps()
    var _err = EntityDb.connect("register_trap", self, "_on_EntityDb_register_trap")

func select_trap(idx: int) -> void:
    if self.__traps.empty():
        self.__index = -1 # Invalid value
        _log("Deselect trap")
    else:
        self.__index = _wrap_index(idx, self.__traps)
        _log("Select trap %s (%d)" % [self.__traps[self.__index], self.__index])

func refresh_traps() -> void:
    _log("Refresh trap IDs")
    # TODO: Using all traps for now, change later
    self.__traps = EntityDb.get_all_trap_ids()
    _log("Traps: %s" % [self.__traps])
    select_trap(self.__index)

# EntityDB signals

func _on_EntityDb_register_trap(_name: String):
    refresh_traps()

func _on_EntityDb_unregister_trap(_name: String):
    refresh_traps()

# InputHandler signals

func _on_InputHandler_place_trap():
    if self.__index == -1:
        return
    name = self.__traps[self.__index]
    if not EntityDb.has_trap_id(name):
        _log("Invalid trap name '%s'" % name)
        return
    var id = EntityDb.get_trap_id(name)
    _log("Build '%s (id: %s)'" % [name, id])

func _on_InputHandler_select_trap(index: int):
    select_trap(index)

func _on_InputHandler_select_next_trap():
    select_trap(self.__index + 1)

func _on_InputHandler_select_prev_trap():
    select_trap(self.__index - 1)

# Utility

func _wrap_index(idx: int, arr: Array) -> int:
    return ((idx % arr.size()) + arr.size()) % arr.size()

func _log(msg: String) -> void:
    print("[Builder]: %s" % msg)

# Setters and getters

func _set_index(i: int) -> void:
    BuildPhaseState.selected_trap_index = i

func _get_index() -> int:
    return BuildPhaseState.selected_trap_index

func _set_traps(traps: Array) -> void:
    BuildPhaseState.available_traps = traps

func _get_traps() -> Array:
    return BuildPhaseState.available_traps
