extends Node2D

const ROT_MAX = PI / 4

var active: bool = false
var targets: Array = [] # Array of Node2D
var rot_tick_counter = 0
var rot_update_freq = 10
var shoot_tick_counter = 0
var shoot_update_freq = 60

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
	print(targets.size())
	var rot = target.global_position.angle_to_point(global_position)
	var rot_dist = _angle_rad_dist(rotation, rot)
	print(rotation, ", ", rot)
	if rot_dist < ROT_MAX:
		rotation = rot
	else:
		rotation = lerp_angle(rotation, rot, ROT_MAX / rot_dist)

func _update_shooting() -> void:
	pass

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

func deactivate():
	active = false
	targets.clear()

func _on_Range_body_entered(body: KinematicBody2D):
	if not active:
		return
	if body.is_in_group("Enemies"):
		targets.push_back(body)

func _on_Range_body_exited(body: KinematicBody2D):
	if not active:
		return
	if body.is_in_group("Enemies"):
		targets.remove(targets.find(body))
