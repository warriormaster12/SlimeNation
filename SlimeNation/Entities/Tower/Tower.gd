extends Node2D

const ROT_MAX = PI / 4

var active: bool = false
var targets: Array = [] # Array of Node2D
var rot_tick_counter = 0
var rot_update_freq = 10
var shoot_tick_counter = 0
var shoot_update_freq = 60

onready var sfxBuild = $SfxBuild

func _process(delta):
	if not active:
		return
	rot_tick_counter += 1
	shoot_tick_counter += 1
	if rot_tick_counter % rot_update_freq == 0:
		_update_rotation()
	if shoot_tick_counter % shoot_update_freq == 0:
		_update_shooting()

func _update_rotation() -> void:
	if targets.empty():
		return
	var target = _find_closest_target()
	if target == null:
		return
	var rot = target.global_position.angle_to_point(global_position)
	var rot_dist = _angle_rad_dist(rotation, rot)
	if rot_dist < ROT_MAX:
		rotation = rot
	else:
		rotation = lerp_angle(rotation, rot, ROT_MAX / rot_dist)

func _update_shooting() -> void:
	if targets.empty():
		return
	var instance = EntityDb.get_entity_node("Bullet").instance()
	instance.global_position = global_position
	if instance.has_method("set_direction"):
		instance.set_direction(Vector2(cos(rotation), sin(rotation)))
	get_parent().add_child(instance)

func _find_closest_target() -> Node2D:
	var p0 = global_position
	var min_dist = 1000000000 # Max value
	var closest = null
	for target in self.targets:
		var p1 = (target as Node2D).global_position
		var dist = (p1 - p0).length()
		if dist < min_dist:
			closest = target
			min_dist = dist
	return closest

func _angle_rad_dist(a1: float, a2: float) -> float:
	var diff = a2 - a1
	while (diff < -PI):
		diff += 2 * PI
	while (diff > PI):
		diff -= 2 * PI
	return abs(diff)

func activate():
	active = true
	sfxBuild.play()

func deactivate():
	active = false
	targets.clear()

func _on_Range_area_entered(area: Area2D):
	if not active:
		return
	if area.is_in_group("Enemies"):
		targets.push_back(area)

func _on_Range_area_exited(area: Area2D):
	if not active:
		return
	if area.is_in_group("Enemies"):
		targets.remove(targets.find(area))
