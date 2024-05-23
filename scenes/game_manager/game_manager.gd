extends Node2D


func _process(_delta):
	_handle_exit()


func _handle_exit() -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
