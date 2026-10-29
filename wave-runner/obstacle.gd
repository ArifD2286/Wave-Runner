extends Node2D

# Notes/revision:

@export var gap_size: float = 250.0
@export var wall_height: = 750.0
@onready var top_wall: StaticBody2D = $"Top obstacle"
@onready var bottom_wall: StaticBody2D = $"Bottom obstacle"


func _ready() -> void:
	var offset = gap_size / 2.0 + wall_height / 2.0
	top_wall.position.y = -offset
	bottom_wall.position.y = offset
