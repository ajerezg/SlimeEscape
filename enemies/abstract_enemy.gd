extends CharacterBody2D

class_name AbstractEnemy

@export var speed := 200.0
@export var direction := Vector2.RIGHT
@export var jump := -200.0

func get_hit(damage: float):
	assert(false, "Function receive_hit not implemented for " + name)

func get_killed():
	assert(false, "Function get_killed not implemented for " + name)
