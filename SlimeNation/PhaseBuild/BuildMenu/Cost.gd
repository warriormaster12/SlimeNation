extends Label

func _process(delta):
	if PlayerState.money < 20:
		modulate = Color.red
	else:
		modulate = Color.white
