extends Node2D

export (NodePath) var container_path
onready var container = get_node(container_path)

# Index of the selected trap
var __index: int = -1 setget _set_index, _get_index
# String[]
var __traps: Array = [] setget _set_traps, _get_traps

const CELL_SIZE = 16
const ROTATE_STEP_DEG = 90.0

var cursor_pos: Vector2 = Vector2()
var trap_ghost: Node = null
var colliders_counter: int = 0
var ghost_rotation_deg: float = 0


func _init() -> void:
	var _err
	_err = EntityDb.connect("register_trap", self, "_on_EntityDb_register_trap")
	_err = EntityDb.connect("unregister_trap", self, "_on_EntityDb_unregister_trap")

func place_trap() -> void:
	if self.__index == -1 or colliders_counter > 0:
		return
	name = self.__traps[self.__index]
	if not EntityDb.has_trap_id(name):
		_log("Invalid trap name '%s'" % name)
		return
	var id = EntityDb.get_trap_id(name)
	var nodeScene = EntityDb.get_entity_node(name)
	if nodeScene == null:
		_log("No resource loaded for '%s'" % name)
		return
	var pos = _fit_to_cell(cursor_pos)
	var node = nodeScene.instance()
	node.position = pos
	node.rotation = ghost_rotation_deg * PI / 180.0
	container.add_child(node)
	_log("Build '%s (id: %s)' at (%d, %d)" % [name, id, pos.x, pos.y])

func rotate_trap() -> void:
	if self.__index == -1 or trap_ghost == null:
		return
	ghost_rotation_deg += ROTATE_STEP_DEG
	ghost_rotation_deg = floor(ghost_rotation_deg / ROTATE_STEP_DEG) * ROTATE_STEP_DEG
	while ghost_rotation_deg >= 360:
		ghost_rotation_deg -= 360
	trap_ghost.rotation = ghost_rotation_deg * PI / 180.0

func select_trap(idx: int) -> void:
	if trap_ghost != null:
		trap_ghost.queue_free()
		remove_child(trap_ghost)
		trap_ghost = null
	if self.__traps.empty() or idx < 0:
		self.__index = -1 # Invalid value
		_log("Deselect trap")
	else:
		self.__index = _wrap_index(idx, self.__traps)
		var name = self.__traps[self.__index]
		_log("Select trap %s (%d)" % [name, self.__index])
		var nodeScene = EntityDb.get_entity_node(name)
		if nodeScene == null:
			_log("No resource loaded for '%s'" % name)
			return
		trap_ghost = nodeScene.instance()
		trap_ghost.z_index = 10
		trap_ghost.position = _fit_to_cell(cursor_pos)
		trap_ghost.rotation = ghost_rotation_deg * PI / 180.0
		trap_ghost.modulate = Color(1, 1, 1, 0.5)
		var _err
		_err = trap_ghost.get_node("Collider").connect("area_entered", self, "_on_Ghost_area_entered")
		_err = trap_ghost.get_node("Collider").connect("area_exited", self, "_on_Ghost_area_exited")
		add_child(trap_ghost)

func refresh_traps() -> void:
	_log("Refresh trap IDs")
	# TODO: Using all traps for now, change later
	self.__traps = EntityDb.get_all_trap_ids()
	_log("Traps: %s" % [self.__traps])
	select_trap(self.__index)

# Built-in functions

func _ready():
	refresh_traps()

func _process(_delta):
	if self.__index == -1:
		return
	if trap_ghost != null:
		cursor_pos = GameCamera.get_global_mouse_position()
		trap_ghost.position = _fit_to_cell(cursor_pos)

# Trap ghost signals

func _on_Ghost_area_entered(_area: Area2D):
	colliders_counter += 1
	trap_ghost.modulate = Color(0.5, 0, 0, 0.5)

func _on_Ghost_area_exited(_area: Area2D):
	colliders_counter -= 1
	if colliders_counter == 0:
		trap_ghost.modulate = Color(1, 1, 1, 0.5)

# EntityDB signals

func _on_EntityDb_register_trap(_name: String):
	refresh_traps()

func _on_EntityDb_unregister_trap(_name: String):
	refresh_traps()

# InputHandler signals

func _on_InputHandler_place_trap():
	place_trap()

func _on_InputHandler_rotate_trap():
	rotate_trap()

func _on_InputHandler_select_trap(index: int):
	select_trap(index)

func _on_InputHandler_select_next_trap():
	select_trap(_wrap_index(self.__index + 1, self.__traps))

func _on_InputHandler_select_prev_trap():
	select_trap(_wrap_index(self.__index - 1, self.__traps))

# BuildMenu signals

func _on_BuildMenu_state_changed(is_open: bool):
	if is_open:
		select_trap(0)
	else:
		select_trap(-1)

func _on_BuildMenu_trap_selected(index: int):
	select_trap(index)

# Utility

func _wrap_index(idx: int, arr: Array) -> int:
	return ((idx % arr.size()) + arr.size()) % arr.size()

func _fit_to_cell(pos: Vector2) -> Vector2:
	return (pos / CELL_SIZE).floor() * CELL_SIZE

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
