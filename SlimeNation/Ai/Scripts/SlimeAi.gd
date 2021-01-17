extends KinematicBody2D

export (int) var speed = 100

var direction : Vector2
var velocity : Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	direction = Vector2()
	

	direction.x += 1 
	
	direction = direction.normalized() 
	velocity = direction * speed * delta
	
	move_and_collide(velocity)
