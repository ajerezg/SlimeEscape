class_name PlayerState

extends Node

var player: Player = null
var sprite_2d: Sprite2D = null
var animation_player: AnimationPlayer = null
var next_state: PlayerState = null


func process_input(event: InputEvent):
	pass


func run(delta):
	assert(false, "Method run is not implemented for " + name)


func can_enter(event: InputEvent):
	assert(false, "Method can_enter not implemented for " + name)

func can_enter_middle_run():
	assert(false, "Method can_enter_middle_run not implemented for "+ name)

func on_enter():
	pass


func on_exit():
	pass


func get_name_str():
	return name
