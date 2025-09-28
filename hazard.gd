extends Area2D
signal hazarded(name)

func _process(delta: float) -> void:
	if get_overlapping_bodies().size() > 0:
		hazarded.emit(get_overlapping_bodies()[0].name)
