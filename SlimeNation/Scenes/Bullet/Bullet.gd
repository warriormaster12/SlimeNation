extends Node2D

const SPEED = 500
const DAMAGE = 7
var direction = Vector2(0, 0)

func _process(delta):
	position += direction * SPEED * delta

func set_direction(dir: Vector2) -> void:
	self.direction = dir.normalized()