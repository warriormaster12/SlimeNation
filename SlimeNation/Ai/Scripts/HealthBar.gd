extends ProgressBar


func _on_DefaultSlime_health_changed(current: int):
	value = current
	print("health changed")
