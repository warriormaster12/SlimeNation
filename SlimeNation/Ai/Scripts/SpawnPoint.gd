extends Position2D

export (PackedScene) var object_to_spawn
export var random_time_range = {"min": 0.2, "max": 1.0}
onready var timer = $Timer



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.autostart = true
	timer.wait_time = rand_range(random_time_range.min,random_time_range.max)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_Timer_timeout():
	_spawnCharacter()
	timer.wait_time = rand_range(random_time_range.min,random_time_range.max)
	
	
func _spawnCharacter():
	var object_instance = object_to_spawn.instance()
	object_instance.position = self.position
	get_parent().add_child(object_instance)
	
