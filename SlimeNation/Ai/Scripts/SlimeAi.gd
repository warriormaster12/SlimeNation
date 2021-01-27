extends KinematicBody2D

export (int) var speed = 100

var direction : Vector2
var velocity : Vector2

onready var path_follow = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	direction = Vector2()
	_get_path(delta)

func _get_path(delta):
	#last position 
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + speed * delta)
	#current position 
	var pos = path_follow.get_global_position()
	direction = pos
