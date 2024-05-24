extends CharacterBody2D

var gravity = 20
var terminal_velocity = 100
var jump_force = 300

@onready var sprite = $AnimatedSprite2D
@onready var player_died_signal = GameManager.player_died


func _ready():
	reset()
	GameManager.player_died.connect(on_player_died)
	GameManager.reset.connect(reset)


func reset():
	sprite.rotation_degrees = 0
	sprite.flip_h = false
	position = Vector2(135, 240)


func on_player_died():
	sprite.rotation_degrees = 180
	sprite.flip_h = true


func _process(_delta: float):
	if GameManager.state == GameManager.State.PLAYING:
		process_alive()
	elif GameManager.state == GameManager.State.DEAD:
		process_dead()


func process_dead():
	accelerate()
	move_and_slide()


func process_alive():
	handle_jump()
	update_rotation()
	accelerate()
	move_and_slide()


func accelerate():
	velocity.y += gravity


func handle_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force


func update_rotation() -> void:
	if velocity.y < -5:
		sprite.rotation_degrees = 315
	elif velocity.y > 5:
		sprite.rotation_degrees = 45
	else:
		sprite.rotation_degrees = 0
