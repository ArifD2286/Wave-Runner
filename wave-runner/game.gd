extends Node2D

# Notes/revision:
# The [game_playing] var will be referred to by other scripts

@onready var start_label: Label = $CanvasLayer/Label
@onready var end_label: Label = $CanvasLayer/Label2
var game_playing: bool = false
var restart: bool = false
var game_over: bool = false



func _ready() -> void:
	end_label.hide()


func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("ui_accept"):
		return
	if game_over:
		if restart:
			get_tree().reload_current_scene()
	elif not game_playing:
		start_game()


func start_game() -> void:
	game_playing = true
	start_label.hide()


func end_game() -> void:
	game_playing = false
	game_over = true
	end_label.show()
	# the line of code below is the delay, only after it finishes the player can restart.
	await get_tree().create_timer(0.5).timeout
	restart = true
