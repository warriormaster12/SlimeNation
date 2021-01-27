extends Camera2D


const ZOOM_STEP = 1.2
const MAX_ZOOM = pow(ZOOM_STEP, 5)
const MIN_ZOOM = 1 / pow(ZOOM_STEP, 2)

var _is_dragging: bool = false
var _drag_start_screen: Vector2 = Vector2()
var _drag_start_camera: Vector2 = Vector2()


func _ready():
	make_current()

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT:
		get_tree().set_input_as_handled()
		if event.is_pressed():
			_drag_start_camera = Vector2(position)
			_drag_start_screen = event.position
			_is_dragging = true
		else:
			_is_dragging = false
	elif event is InputEventMouseMotion and _is_dragging:
		get_tree().set_input_as_handled()
		position = _drag_start_camera - (event.position - _drag_start_screen) * zoom

	if event.is_action_pressed("game_camera_zoom_in"):
		zoom_at_pivot(zoom.x * 1.0 / ZOOM_STEP, get_local_mouse_position())
	elif event.is_action_pressed("game_camera_zoom_out"):
		zoom_at_pivot(zoom.x * ZOOM_STEP, get_local_mouse_position())
	elif event.is_action_pressed("game_camera_zoom_reset"):
		zoom_at_pivot(1.0, get_local_mouse_position())

func zoom_at_pivot(factor: float, pivot: Vector2) -> void:
	var clampedZ = min(max(factor, MIN_ZOOM), MAX_ZOOM)
	var new_zoom = Vector2(clampedZ, clampedZ)
	position = position + pivot * (zoom - new_zoom)
	zoom = new_zoom
