extends Node2D

@onready var top_placement: Marker2D = $TopPlacement
@onready var bottom_placement: Marker2D = $BottomPlacement
@onready var pipes_container: Node2D = $PipesContainer
@onready var player_points_container: Node2D = $PlayerPointsContainer

@export var pipe_scene: PackedScene
@export var player_point_scene: PackedScene

var min_offset = -120
var max_offset = 120
var gap = 20
var speed = 120


func _ready():
	GameManager.reset.connect(reset)


func _process(delta: float):
	move_pipes(delta)


func reset():
	for pipe in pipes_container.get_children():
		pipe.queue_free()
	for player_point in player_points_container.get_children():
		player_point.queue_free()


func spawn_pipes() -> void:
	if GameManager.state == GameManager.State.PLAYING:
		var offset = get_random_offset()
		var top_pipe = _build_top_pipe(offset)
		var bottom_pipe = _build_bottom_pipe(offset)

		pipes_container.add_child(top_pipe)
		pipes_container.add_child(bottom_pipe)

		var player_point = player_point_scene.instantiate()
		player_point.position.x = top_pipe.position.x

		player_points_container.add_child(player_point)


func _build_top_pipe(offset: float):
	var top_pipe = pipe_scene.instantiate()
	top_pipe.position = top_placement.position
	top_pipe.position.y += offset
	top_pipe.rotation_degrees = 180
	return top_pipe


func _build_bottom_pipe(offset: float):
	var pipe = pipe_scene.instantiate()
	pipe.position = bottom_placement.position
	pipe.position.y += offset
	return pipe


func get_random_offset() -> float:
	return lerp(min_offset, max_offset, randf())


func move_pipes(delta: float) -> void:
	if GameManager.state == GameManager.State.PLAYING:
		for pipe in pipes_container.get_children():
			pipe.position.x -= speed * delta
		for player_point in player_points_container.get_children():
			player_point.position.x -= speed * delta


func _on_timer_timeout():
	spawn_pipes()
