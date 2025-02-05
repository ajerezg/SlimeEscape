extends Node2D

class_name HealthComponent

@export var MAX_HEALTH := 10
@export var entity: Node

var health : float

func _ready() -> void:
	health = MAX_HEALTH
	if !entity.has_method("get_killed"):
		assert(false, "Entity " + str(entity.name) + "does not have the method get_killed")


func get_hit(damage: float):
	health -= damage
	if health <= 0:
		entity.get_killed()
