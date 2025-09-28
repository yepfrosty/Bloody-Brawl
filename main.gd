extends Node2D
@onready var player1 = $"Player 1"
@onready var player2 = $"Player 2"
@onready var score_label = $"Camera2D/Label"
@onready var camera = $"Camera2D"

func _on_reset_button_pressed() -> void:
	player1.health = 100
	player2.health = 100
	player1.global_position = Vector2(-443,96)
	player2.global_position = Vector2(1813,-33)
	camera.locked = false
	score_label.shown = false
	score_label.visible = false
	
	
