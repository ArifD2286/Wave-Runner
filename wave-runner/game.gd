extends Node2D

# The [game_playing] var will be referred to by other scripts


@onready var start_label: Label = $CanvasLayer/Label
var game_playing: bool = false


func _physics_process(delta: float) -> void:
	if not game_playing and Input.is_action_just_pressed("ui_accept"):
		start_game()


func start_game() -> void:
	game_playing = true
	start_label.hide()
