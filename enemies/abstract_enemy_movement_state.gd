class_name AbstractEnemyMovementState

extends Node

@export var get_hit_state: AbstractEnemyMovementState

var enemy: AbstractEnemy = null
var sprite_2d: Sprite2D = null
var animation_player: AnimationPlayer = null
var next_state: AbstractEnemyMovementState = null


func run(delta):
	assert(false, "Method run is not implemented for " + name)

func can_enter_middle_run():
	assert(false, "Method can_enter_middle_run not implemented for "+ name)

func on_enter():
	pass

func on_exit():
	pass

func get_name_str():
	return name

func get_hit():
	pass

func crash_on_wall():
	var enemy_is_on_wall = enemy.is_on_wall()
	#var enemy_is_on_floor = enemy.is_on_floor()
	var signs_are_different = sign(enemy.get_wall_normal().x) != sign(enemy.direction.x)
	
	if enemy.is_on_wall() and (sign(enemy.get_wall_normal().x) != sign(enemy.direction.x)):
		#print("crashed!" + str(enemy.get_wall_normal()))
		enemy.direction.x = -enemy.direction.x
		enemy.velocity.x = enemy.direction.x * enemy.speed
