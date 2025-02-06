extends CharacterBody2D

class_name AbstractEnemy

@export var speed := 100.0
@export var direction := Vector2.RIGHT
@export var jump := -200.0
@export var raycast_left: RayCast2D
@export var raycast_right: RayCast2D

func get_hit(damage: float):
	assert(false, "Function receive_hit not implemented for " + name)

func get_killed():
	assert(false, "Function get_killed not implemented for " + name)

func bounce_on_wall():
	if raycast_left.is_colliding() != raycast_right.is_colliding():
		direction.x = -direction.x
	velocity.x = direction.x * speed
