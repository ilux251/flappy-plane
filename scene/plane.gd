extends CharacterBody2D


const SPEED = 200.0
const FLAP_VELOCITY = -300.0

var current_position = 0
var gameover = false
var start_game = false
var coin = 0

func _ready() -> void:
	current_position = global_position.x

func _physics_process(delta: float) -> void:
	if (!can_play() and Input.is_action_just_pressed("flap")):
		start_game = true
		$AnimatedSprite2D.play("fly")
	if (!can_play()):
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	position.x += SPEED * delta

	player_input()

	move_and_slide()

func can_play() -> bool:
	return !gameover and start_game

func player_input() -> void:
	if can_play() and Input.is_action_just_pressed("flap"):
		velocity.y = FLAP_VELOCITY

func game_over():
	print("game over")
	Engine.time_scale = 0.3
	gameover = true
	$AnimatedSprite2D.stop()
	$GameOver.start()

func collect_item(item):
	match (item):
		"coin":
			coin += 1
			print("coin: ", coin)

func _on_game_over_timeout() -> void:
	Engine.time_scale = 1
	gameover = false
	get_tree().reload_current_scene()

func _on_collision_detection_body_entered(body: Node2D) -> void:
	game_over()
