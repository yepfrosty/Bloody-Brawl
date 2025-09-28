extends CharacterBody2D
@export var player_num: String
var SPEED: float = 1000
var ACCEL: float = 500
var AIR_ACCEL: float = ACCEL/4
var DECEL: float = 250
var health:float = 100
var last_dir = 1
var stunned = false
signal died()
@onready var jab_box = $"JabBox"
@onready var health_bar = $"HealthBar"
@onready var area = $JabBox
@onready var stun_timer = $StunTimer
@onready var animation = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D
@onready var jab_timer = $JabCooldown
@onready var hit_sound = $AudioStreamPlayer2D
@onready var dmg_sound = $AudioStreamPlayer2D2
@onready var dash_timer = $DashCooldown
var dash_ready = true
var jab_off_cd = true
var available_jumps = 2

func _physics_process(delta: float) -> void:

	#print(animation.current_animation)
	if health > 0:
		#print(health)
		
		
		velocity.y += 90
		
		var direction = Input.get_axis("Left"+player_num,"Right"+player_num)
		if direction != 0 and not stunned:
			#velocity.x = move_toward(velocity.x, SPEED*direction, ACCEL)
			velocity.x = SPEED*direction
			if is_on_floor() and animation.current_animation != "Attack":
				animation.play("Run")
				available_jumps = 2
		elif not stunned and animation.current_animation != "Attack":
			velocity.x = 0
			animation.play("Idle")
			if is_on_floor():
				available_jumps = 2
			
		elif animation.current_animation != "Attack":
			#animation.play("Hurt")
			#dmg_sound.play()
			pass

		
		if last_dir != direction and direction != 0:
			last_dir = direction
			area.rotate(deg_to_rad(180))
			if sprite.flip_h:
				sprite.flip_h = false
			else:
				sprite.flip_h = true
		
		
		if Input.is_action_just_pressed("Up"+player_num) and available_jumps > 0:
			velocity.y = -2000
			if animation.current_animation != "Attack":
				animation.play("Jump")
			available_jumps -= 1
		
		if Input.is_action_pressed("Down"+player_num) :
			velocity.y = 2000
			global_position.y += 2
			
		#if Input.is_action_just_pressed("Dash"+player_num) and dash_ready:
			#dash_ready = false
			#dash_timer.start()
			#if direction != 0:
				#velocity.x += 3000*direction
				#stun_me()
			#else:
				#velocity.x += 3000*last_dir
				#stun_me()
			
		
		if Input.is_action_just_pressed("Jab"+player_num) and jab_off_cd:
			var enemy = 0
			animation.play("Attack", -1, 4)
			jab_off_cd = false
			jab_timer.start()
			for body in jab_box.get_overlapping_bodies():
				#print(jab_box.get_overlapping_bodies())
				if body is CharacterBody2D and body != $".":
					enemy = body
				#print($".")
			if enemy is CharacterBody2D:
				
				
				enemy.health -= 25
				enemy.available_jumps -= 1
				hit_sound.play()
				
				
				if direction != 0:
					enemy.velocity = Vector2(2500*direction, -2000)
					enemy.stun_me()
					animation.play("Hurt")
					dmg_sound.play()
				else:
					enemy.velocity = Vector2(2500*last_dir, -2000)
					enemy.stun_me()
					enemy.animation.play("Hurt")
					dmg_sound.play()
			else:
				dmg_sound.play()
				health -= 10
		move_and_slide()
	else:
		died.emit()
		
	health_bar.value = health
	

func stun_me():
	stun_timer.start()
	stunned = true

func _on_stun_timer_timeout() -> void:
	stunned = false


func _on_jab_cooldown_timeout() -> void:
	jab_off_cd = true


func _on_dash_cooldown_timeout() -> void:
	dash_ready = true
