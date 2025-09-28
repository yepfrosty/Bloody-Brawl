extends Camera2D
@onready var player1 = $"../Player 1"
@onready var player2 = $"../Player 2"
var max_zoom = 2
var min_zoom = 0.4
var smooth_speed = 0.1
var zoom_distance = 1000
var locked = false
func _process(delta: float) -> void:
	if not locked:
		
		var distance = player1.global_position.distance_to(player2.global_position)
		var zoom_factor = clamp(1 - (distance / zoom_distance), min_zoom, max_zoom)
		#var zoom_factor = 1/(distance / zoom_distance)
		
		var camera_pos = (player1.global_position+player2.global_position)/2
		position = position.lerp(camera_pos, smooth_speed)
		
		var target_zoom = Vector2(zoom_factor, zoom_factor)
		zoom = zoom.lerp(target_zoom, smooth_speed)


func _on_player_died() -> void:
	global_position = Vector2(586, 320)
	locked = true


func _on_player_2_died() -> void:
	global_position = Vector2(586, 320)
	locked = true


func _on_hazard_hazarded(name: Variant) -> void:
	global_position = Vector2(586, 320)
	locked = true
