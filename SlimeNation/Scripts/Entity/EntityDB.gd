extends Node

signal register_trap(name)
signal unregister_trap(name)

# [String]: int, [name]: id
var __trap_id: Dictionary = {}
# [id]: PackedScene
onready var __nodes: Dictionary = {
    # Hard-coded scenes
    0: preload("res://Scenes/FlyPaper/FlyPaper.tscn"),
    1: preload("res://Scenes/BugSpray/BugSpray.tscn")
}


func _init():
    # Load entities
    _load_traps()

func _load_traps() -> void:
    # Not using register_trap_id() to avoid sending signals
    __trap_id["FlyPaper"] = 0
    __trap_id["BugSpray"] = 1

# Registers a trap id.
# @param name The name of the trap
# @param id The id of the trap
func register_trap_id(name: String, id: int) -> void:
    assert(__trap_id.values().find(id) == -1, "Trap with id '%d' already exists" % id)
    __trap_id[name] = id
    emit_signal("register_trap", name)

# Unregisters a trap id.
# @param name The name of the trap
func unregister_trap_id(name: String) -> void:
    if __trap_id.erase(name):
        emit_signal("unregister_trap", name)

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

# Returns a PackedScene that can be instantiated.
# @return null if no scene has been loaded for that name
func get_entity_node(name: String) -> PackedScene:
    var id = get_trap_id(name)
    if __nodes == null or not __nodes.has(id):
        return null
    return __nodes[id]
