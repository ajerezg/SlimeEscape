extends Node2D

class_name EnemySpawner


@export var spawn_time := 5.0
@export var enemy_scene : Resource
@export var random_direction := true

@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	spawn_timer.one_shot = true
	spawn_timer.wait_time = spawn_time


func _process(delta: float) -> void:
	if spawn_timer.is_stopped():
		var new_enemy = enemy_scene.instantiate()
		new_enemy.global_position = global_position
		var factor = 1
		if random_direction:
			factor = 1 if randi_range(1, 2) == 1 else -1
		new_enemy.direction.x =  factor * new_enemy.direction.x
		get_parent().add_child(new_enemy)
		spawn_timer.start()
	
