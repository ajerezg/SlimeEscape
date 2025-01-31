class_name PlayerStateMachine

extends Node

var current_state: PlayerState = null


func process_input(event: InputEvent):
	current_state.process_input(event)


func run_state(delta):
	if current_state.next_state != null:
		switch_state(current_state.next_state)
	current_state.run(delta)


func switch_state(new_state):
	current_state.on_exit()
	current_state = new_state
	current_state.next_state = null
	current_state.on_enter()
