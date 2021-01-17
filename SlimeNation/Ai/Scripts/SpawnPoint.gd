extends Position2D

export (PackedScene) var object_to_spawn
onready var timer = $Timer
onready var object_instance = object_to_spawn.instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.autostart = true
	timer.wait_time = rand_range(0.2,1.0)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(timer.time_left)


func _on_Timer_timeout():
	print("no time left")
	_spawnCharacter()
	
	
func _spawnCharacter():
	get_parent().add_child(object_instance)
	
