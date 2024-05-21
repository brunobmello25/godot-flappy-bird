extends CharacterBody2D

var gravity = 9.6
var terminal_velocity = 20

func _ready():
	pass

func _process(delta):
	velocity.y += gravity
	move_and_slide()
