extends Label
signal game_ended
var shown = false

func _on_player_died() -> void:
	if not shown:
		visible = true
		text = "PLAYER 2 WINS"
		shown = true
		game_ended.emit()
	#print(text)


func _on_player_2_died() -> void:
	if not shown:
		visible = true
		text = "PLAYER 1 WINS"
		shown = true
		game_ended.emit()
	#print(text)


func _on_hazard_hazarded(name: Variant) -> void:
	if not shown:
		visible = true
		if name == "Player 1":
			text = "PLAYER 2 WINS"
		else:
			text = "PLAYER 1 WINS"
		shown = true
		game_ended.emit()
