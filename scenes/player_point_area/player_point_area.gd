extends Area2D

var player_crossed = false


func _ready():
	pass


func _process(_delta):
	_dealocate_after_leave_screen()


func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		if !player_crossed:
			player_crossed = true
			GameManager.score_point()


func _dealocate_after_leave_screen():
	if position.x < -30:
		queue_free()
