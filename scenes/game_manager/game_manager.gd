extends Node2D

signal player_died
signal reset
signal player_scored_point

enum State { PLAYING, DEAD }

var state: State = State.PLAYING

var player_score = 0


func _process(_delta):
	_handle_reset()
	_handle_exit()


func kill_player() -> void:
	state = State.DEAD
	player_died.emit()


func _handle_exit() -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()


func _handle_reset() -> void:
	if Input.is_action_just_pressed("reset") and state == State.DEAD:
		state = State.PLAYING
		player_score = 0
		reset.emit()


func score_point() -> void:
	player_score += 1
	player_scored_point.emit()
