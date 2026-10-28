extends Node2D

# Notes/revision:
# The [game_playing] var will be referred to by other scripts

@onready var start_label: Label = $CanvasLayer/Label
@onready var end_label: Label = $CanvasLayer/Label2
@onready var player: CharacterBody2D = $CharacterBody2D
@export var wall_scene: PackedScene
@export var spacing: float = 500.0
@export var spawn_dist: float = 1500.0
@export var despawn_dist: float = 800.0
@export var max_gap_shift: float = 200.0
@export var min_gap_y: float = 160.0
@export var max_gap_y: float = 488.0
var next_spawn_x: float
var last_gap_y: float = 324.0
var walls: Array = []
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
