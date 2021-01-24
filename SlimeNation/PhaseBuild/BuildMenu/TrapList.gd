extends VBoxContainer

var trap_icon = load("res://PhaseBuild/BuildMenu/TrapIcon/TrapIcon.tscn")
var selected_item: Control

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(trap_icon != null, "Could not find scene 'TrapIcon.tscn'")
	clear()

func clear() -> void:
	for n in get_children():
		remove_child(n)
		n.queue_free()

func add_item(name: String, icon: String) -> void:
	var item = trap_icon.instance()
	item.set_text(name)
	item.set_icon(icon)
	var _err = item.connect("pressed", self, "_on_TrapIcon_selected",
		[item])
	add_child(item)

func select_item(index: int) -> void:
	print("[TrapList]: Select %d" % index)
	for c in get_children():
		c.select(false)
	if index >= 0 and index < get_child_count():
		get_child(index).select(true)


# Signal handlers

func _on_TrapIcon_selected(item: Control):
	var index = item.get_index()
	BuildPhaseState.selected_trap_index = index
	select_item(index)
