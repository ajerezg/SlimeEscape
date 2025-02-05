extends Area2D

class_name HitboxComponent

@export var entity: Node

func on_ready():
	if !entity.has_method("get_hit"):
		assert(false, "Entity " + str(entity.name) + "does not have the method get_hit")

func get_hit(damage: float):
	entity.get_hit(damage)
