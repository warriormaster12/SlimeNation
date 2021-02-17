extends Node2D

export (int) var speed = 100

signal health_changed(current)

export(int) var MAX_HEALTH = 100

var direction : Vector2
var velocity : Vector2
var health: int setget _set_health

onready var path_follow = get_parent()

func _ready():
	self.health = MAX_HEALTH

func _physics_process(delta):
	direction = Vector2()
	_follow_path(delta)

func _follow_path(delta):
	if not path_follow is PathFollow2D:
		return
	#last position
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + speed * delta)
	#current position
	var pos = path_follow.get_global_position()
	direction = pos

func _set_health(hp: int) -> void:
	health = hp
	emit_signal("health_changed", health)
	if (health <= 0):
		self.queue_free()


func _on_Collider_area_entered(area: Area2D):
	if area.is_in_group("Bullets"):
		var damage = 1
		if "DAMAGE" in area.get_parent():
			damage = area.get_parent().DAMAGE
		self.health -= damage
		area.get_parent().queue_free()
