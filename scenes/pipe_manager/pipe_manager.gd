extends Node2D

@onready var top_placement: Marker2D = $TopPlacement
@onready var bottom_placement: Marker2D = $BottomPlacement
@onready var pipes_container: Node2D = $PipesContainer

@export var pipe_scene: PackedScene

var min_top_height = -80;
var max_top_height = 100;
var speed = 120;

func _ready():
	pass

func _process(delta: float):
	move_pipes(delta)

func spawn_pipes() -> void:
	var top_pipe = pipe_scene.instantiate()
	top_pipe.position.x = top_placement.position.x
	top_pipe.position.y = max_top_height
	top_pipe.rotation_degrees = 180
	pipes_container.add_child(top_pipe)

func move_pipes(delta: float) -> void:
	for pipe in pipes_container.get_children():
		pipe.position.x -= speed * delta

func _on_timer_timeout():
	spawn_pipes()
