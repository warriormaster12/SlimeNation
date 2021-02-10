extends Node

signal register_entity(name)
signal register_trap(name)
signal unregister_trap(name)

# [String]: int, [name]: id
var __node_id: Dictionary = {}
# [id]: PackedScene
onready var __nodes: Dictionary = {
	# Hard-coded scenes
	0: preload("res://Scenes/FlyPaper/FlyPaper.tscn"),
	1: preload("res://Scenes/Tower/Tower.tscn"),
	2: preload("res://Scenes/Bullet/Bullet.tscn"),
}
var traps = [] # String[]


func _init():
	# Load entities
	_load_nodes()
	_load_traps()

func _load_nodes() -> void:
	__node_id["FlyPaper"] = 0
	__node_id["Tower"] = 1
	__node_id["Bullet"] = 2

func _load_traps() -> void:
	traps.append("FlyPaper")
	traps.append("Tower")

func _register_entity(name: String, scene: PackedScene) -> void:
	# This is okay because we can't unregister entities
	var id = __nodes.size()
	__nodes[id] = scene
	__node_id[name] = id
	emit_signal("register_entity", name)

# Registers an entity as a trap
# @param name The name of the entity
func register_as_trap(name: String) -> void:
	assert(not traps.has(name), "Trap with name '%v' already exists" % name)
	traps.append(name)
	emit_signal("register_trap", name)

# Unregisters an entity as a trap.
# @param name The name of the entity
func unregister_as_trap(name: String) -> void:
	if traps.remove(traps.find(name)):
		emit_signal("unregister_trap", name)

# Returns the names of all of the entities registered as traps.
# @return An Array of Strings
func get_trap_names() -> Array:
	return [] + traps

# Gets the id of an entity by name.
# @param name The name of the entity
# @return -1 if the the entity does not exist
func get_entity_id(name: String) -> int:
	return __node_id.get(name, -1)

# Checks if a trap with the name exists.
# @param name The name of the entity
func has_entity(name: String) -> bool:
	return __node_id.has(name)

# Returns a PackedScene that can be instantiated.
# @return null if no scene has been loaded for that name
func get_entity_node(name: String) -> PackedScene:
	var id = get_entity_id(name)
	if __nodes == null or not __nodes.has(id):
		return null
	return __nodes[id]
