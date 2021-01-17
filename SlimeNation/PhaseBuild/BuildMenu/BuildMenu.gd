extends WindowDialog

onready var __trap_list = $Margin/Scroll/HBox/TrapList
var is_open = false

func _ready():
    assert(__trap_list != null, "Could not find child 'TrapList'")
    get_close_button().hide()
    var _err
    _err = BuildPhaseState.connect("available_traps_changed", self, "_on_available_traps_changed")
    _err = BuildPhaseState.connect("selected_trap_index_changed", self, "_on_selected_trap_index_changed")
    refresh_traps()
    call_deferred("open_menu")

func open_menu() -> void:
    popup()
    is_open = true

func close_menu() -> void:
    visible = false
    is_open = false

func refresh_traps() -> void:
    __trap_list.clear()
    for trap in BuildPhaseState.available_traps:
        __trap_list.add_item(trap, "res://icon.png")
    __trap_list.select_item(BuildPhaseState.selected_trap_index)

func _unhandled_input(event):
    if event is InputEventMouseButton:
        # WindowDialog automatically sets visible to false when the
        # property 'exclusive' is false. Setting the 'exclusive' property
        # to true, blocks the event propagation and as such, cannot be used.
        if is_open:
            visible = true

    if event.is_action_pressed("game_build_menu_toggle"):
        if visible:
            close_menu()
        else:
            open_menu()

func _on_available_traps_changed() -> void:
    refresh_traps()

func _on_selected_trap_index_changed(idx: int) -> void:
    __trap_list.select_item(idx)
