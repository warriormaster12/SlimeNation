extends Camera2D

const CAMERA_MOVE_THRESHOLD = 0.7;
const CAMERA_MOVE_SPEED = 200;

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	var pos = __get_normalized_mouse_pos();
	if pos.x > CAMERA_MOVE_THRESHOLD:
		position.x += CAMERA_MOVE_SPEED * delta
	elif pos.x < -CAMERA_MOVE_THRESHOLD:
		position.x -= CAMERA_MOVE_SPEED * delta;

	if pos.y > CAMERA_MOVE_THRESHOLD:
		position.y += CAMERA_MOVE_SPEED * delta
	elif pos.y < -CAMERA_MOVE_THRESHOLD:
		position.y -= CAMERA_MOVE_SPEED * delta;

# x: -1 -> 1
# y: -1 -> 1
func __get_normalized_mouse_pos() -> Vector2:
	var pos = get_local_mouse_position()
	var size = get_viewport_rect().size;
	return pos / (size / 2.0)
