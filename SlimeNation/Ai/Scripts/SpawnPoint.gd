extends Position2D

export (NodePath) var path
export var random_time_range = {"min": 0.2, "max": 1.0}
onready var timer = $Timer
onready var path_node = get_node(path)




# Called when the node enters the scene tree for the first time.
func _ready():
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = rand_range(random_time_range.min,random_time_range.max)
	timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_Timer_timeout():
	_spawn_character()
	timer.wait_time = rand_range(random_time_range.min,random_time_range.max)



func _spawn_character():
	var object_instance = EntityDb.get_entity_node("DefaultSlime").instance()
	var path_follow = PathFollow2D.new()
	path_follow.set_name("path_follow")
	path_follow.rotate = false
	path_follow.loop = false
	path_node.add_child(path_follow)
	path_follow.add_child(object_instance)

