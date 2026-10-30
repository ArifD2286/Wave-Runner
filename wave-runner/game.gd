extends Node2D

# Notes/revision:
# The [game_playing] var will be referred to by other scripts

@onready var score_label: Label = $CanvasLayer/LiveScore
@onready var high_score: Label = $CanvasLayer/HighestScore
@onready var start_label: Label = $CanvasLayer/Label
@onready var end_label: Label = $CanvasLayer/Label2
@onready var player: CharacterBody2D = $CharacterBody2D
@onready var scoresfx: AudioStreamPlayer = $ScoreSFX
@onready var game_oversfx: AudioStreamPlayer = $GameOverSFX
@export var wall_scene: PackedScene
@export var spacing: float = 500.0
@export var spawn_dist: float = 1500.0
@export var despawn_dist: float = 800.0
@export var max_gap_shift: float = 200.0
@export var min_gap_y: float = 160.0
@export var max_gap_y: float = 488.0
var next_spawn_x: float
var last_gap_y: float = 324.0
var wall_array: Array = []
var game_playing: bool = false
var restart: bool = false
var game_over: bool = false
var score: int = 0
var next_score_x: float


func _ready() -> void:
	end_label.hide()
	next_spawn_x = player.global_position.x + 800.0
	next_score_x = next_spawn_x
	high_score.text = "Highest Score: " + str(Global.high_score)


func _process(delta: float) -> void:
	if not Input.is_action_just_pressed("ui_accept"):
		return
	if game_over:
		if restart:
			get_tree().reload_current_scene()
	elif not game_playing:
		start_game()


func _physics_process(delta: float) -> void:
	if player.global_position.x > next_score_x:
		score += 1
		scoresfx.play()
		score_label.text = "Score: " + str(score)
		next_score_x += spacing
	while next_spawn_x < player.global_position.x + spawn_dist:
		spawn_wall()
	# [wall_array[0]] is the first item in array, start from [0] instead of [1]
	while wall_array.size() > 0 and wall_array[0].position.x < player.global_position.x - despawn_dist:
		# [pop_front()] removes the first item from the array and hands it back.
		var old_wall = wall_array.pop_front()
		# [queue_free()] deletes the node from the game
		old_wall.queue_free()


func start_game() -> void:
	game_playing = true
	start_label.hide()


func end_game() -> void:
	game_playing = false
	game_over = true
	game_oversfx.play()
	end_label.show()
	if score > Global.high_score:
		Global.high_score = score
		high_score.text = "Highest Score: " + str(Global.high_score)
	# the line of code below is the delay, only after it finishes the player can restart.
	await get_tree().create_timer(0.5).timeout
	restart = true


func spawn_wall() -> void:
	# [instantiate()] makes a new copy from the original scene
	var wall = wall_scene.instantiate()
	# [randf_range(a, b)] makes a random number between the range a and b.
	last_gap_y += randf_range(-max_gap_shift, max_gap_shift)
	# [clampf(val, min, max)] keeps a number inside a range.
	# If the val is lower than min, then it gives the minimum as the val is lower.
	# This applies to max also.
	last_gap_y = clampf(last_gap_y, min_gap_y, max_gap_y)
	wall.position = Vector2(next_spawn_x, last_gap_y)
	add_child(wall)
	# [append()] adds  a single value at the back of an array
	wall_array.append(wall)
	next_spawn_x += spacing
