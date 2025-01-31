class_name PlayerState

extends Node

var player: CharacterBody2D = null
var sprite_2d: Sprite2D = null
var animation_player: AnimationPlayer = null
var next_state: PlayerState = null


func process_input(event: InputEvent):
	pass


func run(delta):
	assert(false, "Method run is not implemented for " + name)


func can_enter(event: InputEvent):
	assert(false, "Method can enter not implemented for " + name)


func on_enter():
	pass


func on_exit():
	pass


func get_name_str():
	return name
