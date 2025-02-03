extends CharacterBody2D

class_name AbstractEnemy

@export var hp := 10.0
@export var speed := 200.0
@export var direction := Vector2.RIGHT
@export var jump := -200.0

func receive_hit(damage: float):
	assert(false, "Function receive_hit not implemented for " + name)
	
