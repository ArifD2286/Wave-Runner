extends Line2D


@export var max_points: int = 60
@onready var player: Node2D = get_parent()


func _ready() -> void:
	# [top_leve] makes the whole trail drag along with the player
	top_level = true
	global_position = Vector2.ZERO


func _physics_process(delta: float) -> void:
	add_point(player.global_position)
	# [if] statement below makes sure that the length of the trail is limited
	if get_point_count() > max_points:
		# the line below removes the oldest point, [0] is the start of the line.
		remove_point(0)
