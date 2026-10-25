extends CharacterBody2D

# Notes/revision: ["ui_accept"] is a built in action mapped to space and enter



@export var vertical_speed: float = 750.0
@export var forward_speed: float = 450.0
var direction: int = 1


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		direction = -direction
	velocity.y = direction * vertical_speed
	velocity.x = forward_speed
	move_and_slide()
	
