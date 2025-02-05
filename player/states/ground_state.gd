extends PlayerState


@export var air_state: PlayerState
#@export var attack1_state: PlayerState


func process_input(event: InputEvent):
	if air_state.can_enter(event):
		next_state = air_state
		#print("changin to air by event")
	#elif attack1_state.can_enter(event):
	#	next_state = attack1_state


func can_enter_middle_run():
	return player.is_on_floor()


func run(delta):
	if air_state.can_enter_middle_run():
		next_state = air_state
		#print("changing to air mid run")
	else:
		# prev calculations
		var direction = Input.get_axis("left", "right")
		#var mouse_vector = character.get_relative_mouse_position()
		
		#var is_moving = direction != 0
		#var is_moving_where_looking = mouse_vector.x * direction >= 0
		#var is_looking_left = mouse_vector.x < 0
		# movement
		player.move_x_axis(direction)
		# animation
		#if is_moving:
		#	if is_moving_where_looking:
		#		animation_player.play("run")
		#	else:
		#		animation_player.play_backwards("run")
		#else:
		animation_player.play("idle")
		#sprite.flip_h = is_looking_left
			
	
