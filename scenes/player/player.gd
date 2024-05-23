extends CharacterBody2D

var gravity = 20
var terminal_velocity = 100
var jump_force = 300

@onready var sprite = $AnimatedSprite2D


func _ready():
	pass


func _process(_delta: float):
	handle_jump()
	update_rotation()
	accelerate()
	move_and_slide()


func accelerate():
	velocity.y += gravity
	#velocity.y = min(velocity.y + gravity, terminal_velocity)


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
