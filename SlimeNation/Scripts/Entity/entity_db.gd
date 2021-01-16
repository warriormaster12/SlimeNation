extends Node


# [String]: int, [name]: id
var __trap_id: Dictionary = {}


func _init():
    # Load entities
    _load_traps()

func _load_traps() -> void:
    __trap_id["Default"] = 0
    __trap_id["Spikes"] = 1

# Registers a trap id
# @param name The name of the trap
# @param id The id of the trap
func register_trap(name: String, id: int) -> void:
    assert(__trap_id.values().find(id) == -1, "Trap with id '%d' already exists" % id)
    __trap_id[name] = id

# Gets the id of a trap by name.
# @param name The name of the trap
# @return -1 if the the trap does not exist
func get_trap_id(name: String) -> int:
    return __trap_id.get(name, -1)

# Checks if a trap with the name exists.
func has_trap_id(name: String) -> bool:
    return __trap_id.has(name)

# Returns all registered trap ids.
# @return An Array of Strings
func get_all_trap_ids() -> Array:
    return __trap_id.keys()
