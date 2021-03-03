extends Node2D

export (int) var speed = 100

signal health_changed(current)

export(int) var MAX_HEALTH = 100

var direction : Vector2
var velocity : Vector2
var health: int setget _set_health

var alive = true

onready var path_follow = get_parent()
onready var sfx_death = $SfxDeath

func _ready():
	self.health = MAX_HEALTH

func _physics_process(delta):
	direction = Vector2()
	_follow_path(delta)

func _follow_path(delta):
	if not path_follow is PathFollow2D:
		return

	if not alive:
		# Wait until sfx_death has finished
		$Explosion._emit_particle()
		$Sprite.visible = false 
		if not sfx_death.playing:
			self.queue_free()
		return

	#last position
	var prepos = path_follow.get_global_position()
	path_follow.set_offset(path_follow.get_offset() + speed * delta)
	#current position
	var pos = path_follow.get_global_position()
	direction = pos

	if path_follow.unit_offset == 1.0:
		self.queue_free()


func _set_health(hp: int) -> void:
	health = hp
	emit_signal("health_changed", health)
	if (alive and health <= 0):
		PlayerState.money += 5
		alive = false
		sfx_death.play()


func _on_Collider_area_entered(area: Area2D):
	if area.is_in_group("Bullets"):
		var damage = 1
		if "DAMAGE" in area.get_parent():
			damage = area.get_parent().DAMAGE
		self.health -= damage
		area.get_parent().queue_free()
