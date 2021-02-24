extends Node2D

const SPEED = 500
const DAMAGE = 7
var direction = Vector2(0, 0)

# Time to live
var ttl = 5
var alive_timer = 0

func _process(delta):
	position += direction * SPEED * delta
	alive_timer += delta
	if alive_timer > ttl:
		queue_free()

func set_direction(dir: Vector2) -> void:
	self.direction = dir.normalized()
