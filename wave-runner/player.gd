extends CharacterBody2D

# Notes/revision:
# ["ui_accept"] is a built in action mapped to space and enter

@onready var game = get_parent()
@onready var sprite: Node2D = $Sprite2D
@onready var hitbox: Node2D = $CollisionShape2D
@export var vertical_speed: float = 600.0
@export var forward_speed: float = 400.0
var direction: int = 1


func _physics_process(delta: float) -> void:
	if not game.game_playing:
	# [return] stops the function right there
		return
	if Input.is_action_just_pressed("ui_accept"):
		direction = -direction

	velocity.y = direction * vertical_speed
	velocity.x = forward_speed

	sprite.rotation = velocity.angle()
	hitbox.rotation = velocity.angle()

	move_and_slide()
