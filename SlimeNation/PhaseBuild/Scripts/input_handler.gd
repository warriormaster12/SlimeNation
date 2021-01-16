extends Node2D


signal place_trap()
signal select_trap(index)
signal select_next_trap()
signal select_prev_trap()

func _ready():
    pass # Replace with function body.

func _unhandled_input(event):
    if event.is_action_pressed("game_build_place"):
        print("[Input]: Emit place_trap")
        emit_signal("place_trap")
    elif event.is_action_pressed("game_build_select_next_trap"):
        print("[Input]: Emit select_next_trap")
        emit_signal("select_next_trap")
    elif event.is_action_pressed("game_build_select_prev_trap"):
        print("[Input]: Emit select_prev_trap")
        emit_signal("select_prev_trap")
    elif event.is_action_pressed("game_build_select_trap_1"):
        print("[Input]: Emit select_trap 0")
        emit_signal("select_trap", 0)
    elif event.is_action_pressed("game_build_select_trap_2"):
        print("[Input]: Emit select_trap 1")
        emit_signal("select_trap", 1)
    elif event.is_action_pressed("game_build_select_trap_3"):
        print("[Input]: Emit select_trap 2")
        emit_signal("select_trap", 2)
    elif event.is_action_pressed("game_build_select_trap_4"):
        print("[Input]: Emit select_trap 3")
        emit_signal("select_trap", 3)
    elif event.is_action_pressed("game_build_select_trap_5"):
        print("[Input]: Emit select_trap 4")
        emit_signal("select_trap", 4)