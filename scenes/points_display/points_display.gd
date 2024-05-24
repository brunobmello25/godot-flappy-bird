extends CanvasLayer

@onready var label = $Control/Control/MarginContainer/Label


func _ready():
	GameManager.player_scored_point.connect(update_displayed_points)
	GameManager.reset.connect(reset)


func update_displayed_points():
	label.text = str(GameManager.player_score)


func reset():
	label.text = "0"
