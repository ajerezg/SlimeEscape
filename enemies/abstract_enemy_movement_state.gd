class_name AbstractEnemyMovementState

extends Node

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
