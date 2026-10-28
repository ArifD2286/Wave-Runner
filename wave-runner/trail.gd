extends Line2D


@export var max_points: int = 60
@onready var tail: Node2D = $"../Sprite2D/tail"
@onready var game = get_parent().get_parent()


func _ready() -> void:
	# [top_level] stops the trail from moving along with the player so the old points stay put
	top_level = true
	global_position = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if not game.game_playing:
		return
	add_point(tail.global_position)
	# [if] statement below makes sure that the length of the trail is limited
	if get_point_count() > max_points:
		# the line below removes the oldest point, [0] is the start of the line.
		remove_point(0)
