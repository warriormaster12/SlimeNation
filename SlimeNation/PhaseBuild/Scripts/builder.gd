extends Node2D

# Index of the selected trap
var __index: int
# String[]
var __traps: Array = []


func _init() -> void:
    __traps = EntityDb.get_all_trap_ids()
    select_trap(0)

func select_trap(idx: int) -> void:
    if idx >= 0 and idx < __traps.size():
        __index = idx
        print("[Builder]: Select trap %s" % __traps[idx])
    else:
        __index = -1 # Invalid value
        print("[Builder]: Deselect trap")

func _on_InputHandler_place_trap():
    if __index == -1:
        return
    name = __traps[__index]
    if not EntityDb.has_trap_id(name):
        print("[Builder]: Invalid trap name '%s'" % name)
        return
    var id = EntityDb.get_trap_id(name)
    print("[Builder]: Build '%s (id: %s)'" % [name, id])

func _on_InputHandler_select_trap(index: int):
    select_trap(index)

func _on_InputHandler_select_next_trap():
    select_trap(__index + 1)

func _on_InputHandler_select_prev_trap():
    select_trap(__index - 1)
