extends Node2D

export var random_time_range = {"min": 1.0, "max": 3.0}
onready var timer = $Timer
onready var path = $Path

# Whether or not the timer is a wait or spawn timer
# true means it's a wait timer
var spawn_wait = true
var wait_time = 10 # seconds

var spawned_count = 0

func _ready():
	spawn_wait = true
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = rand_range(5, 10) # Initial delay
	timer.start()

func _on_Timer_timeout():
	if not spawn_wait:
		_spawn_character()
	# Implement "waves" delay this way
	if not spawn_wait and spawned_count > 0 and spawned_count % 10 == 0:
		spawn_wait = true
		timer.wait_time = wait_time
	else:
		spawn_wait = false
		timer.wait_time = rand_range(random_time_range.min,random_time_range.max)

func _spawn_character():
	var enemy_name = _select_enemy()
	var object_instance = EntityDb.get_entity_node(enemy_name).instance()
	var path_follow = PathFollow2D.new()
	path_follow.set_name("path_follow")
	path_follow.rotate = false
	path_follow.loop = false
	path.add_child(path_follow)
	path_follow.add_child(object_instance)
	spawned_count += 1

func _select_enemy() -> String:
	if spawned_count >= 20: # First enemy of wave 3
		# Stop spawning after boss
		timer.stop()
		print("Spawn boss")
		return "BossSlime"
	else:
		return "DefaultSlime"
