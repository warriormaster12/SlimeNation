extends Position2D

export (PackedScene) var object_to_spawn
export (NodePath) var path
export var random_time_range = {"min": 0.2, "max": 1.0}
onready var timer = $Timer
onready var path_node = get_node(path)



# Called when the node enters the scene tree for the first time.
func _ready():
	_spawn_character()
	#timer.autostart = true
	#timer.wait_time = rand_range(random_time_range.min,random_time_range.max)
	#timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_Timer_timeout():
	_spawn_character()
	timer.wait_time = rand_range(random_time_range.min,random_time_range.max)


func _spawn_character():
	var object_instance = object_to_spawn.instance()
	object_instance.position = self.position
	path_node.get_child(0).add_child(object_instance)

