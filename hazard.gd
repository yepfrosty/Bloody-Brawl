extends Area2D
signal hazarded(name)
var guy
func _process(delta: float) -> void:
	if get_overlapping_bodies().size() > 0:
		for body in get_overlapping_bodies():
			#print(jab_box.get_overlapping_bodies())
			if body is CharacterBody2D:
				guy = body
		
		if guy is CharacterBody2D:
			hazarded.emit(guy.name)
			guy.health = 0
			guy.global_position = Vector2(99999999999, 9999999999999999)
			guy = 0
