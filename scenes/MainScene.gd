extends Node2D

export (PackedScene) var enemy
export (PackedScene) var explosion

var position_index = 1
var screen_size
var score = 0
var player_dead = false

func _ready():
	screen_size = OS.get_window_size()
	
	move_player($Position1.position)

	$Music.play()

func _process(delta):
	if not player_dead:
		if Input.is_action_just_pressed("move_up"):
			position_index -= 1
			key_pressed()
		elif Input.is_action_just_pressed("move_down"):
			position_index += 1
			key_pressed()
	
	if Input.is_key_pressed(KEY_F):
		spawn_enemy()
		
	position_index = clamp(position_index, 1, 3)
		
func shake_screen():
	pass	
	
func key_pressed():
	var position_chosen = get_node("Position" + str(position_index))
		
	if position_chosen != null:
		move_player(position_chosen.position)		

func spawn_enemy():
	randomize()
	
	var enemyClone = enemy.instance()

	# Gets a random position
	var enemy_position_index = randi() % 4
	if enemy_position_index < 1:
		enemy_position_index = 1

	var position_chosen = get_node("Position" + str(enemy_position_index))

	enemyClone.position = Vector2(screen_size.x, position_chosen.position.y)
	# enemyClone.speed = rand_range(20000.0, 40000.0)

	add_child(enemyClone)

func move_player(position):
	if $Player == null:
		return
	
	$Player.position = position

func player_death(final_position):
	player_dead = true
	
	$Music.stop()
	$Explosion.play()
	
	Globals.camera.shake(500, 0.7, 500)
	
	$ScoreTimer.stop()
	
	var explosionClone = explosion.instance()
	explosionClone.position = final_position
	add_child(explosionClone)
	
	yield(get_tree().create_timer(0.25), "timeout")
	
	$HUD/ColorRectFirst.visible = true
	$HUD/Message.visible = true

	yield(get_tree().create_timer(3.0), "timeout")

	$HUD/Message.text = "Would you like to reset?"
	$HUD/ColorRectFirst.visible = false
	$HUD/ColorRectSecond.visible = true
	$HUD/ResetButton.visible = true
	$HUD/MainMenuButton.visible = true

func reset_game():
	get_tree().reload_current_scene()

func _on_CarTimer_timeout():
	spawn_enemy()
	$CarTimer.wait_time = rand_range(0.25, 1.0)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD/Score.text = str(score)
