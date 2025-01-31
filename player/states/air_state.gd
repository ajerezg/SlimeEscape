extends PlayerState


@export var ground_state: PlayerState
#@export var attack1_state: PlayerState

func process_input(event: InputEvent):
	#if attack1_state.can_enter(event):
	#	next_state = attack1_state
	pass


func can_enter(event: InputEvent):
	if event.is_action_pressed("jump") and player.is_on_floor():
		return true
	return false


func on_enter():
	if player.is_on_floor():
		player.jump()


func run(delta):
	if player.is_on_floor():
		next_state = ground_state
	else:
		# prev calculations
		var direction = Input.get_axis("left", "right")
		#var mouse_vector = player.get_relative_mouse_position()
		
		var is_jumping = player.velocity.y <= 0
		#var is_moving_where_looking = mouse_vector.x * direction >= 0
		#var is_looking_left = mouse_vector.x < 0
		# movement
		player.fall(delta)
		player.move_x_axis(direction)
		# animation
		if is_jumping:
			animation_player.play("jump")
		else:
			animation_player.play("jump")
		#sprite.flip_h = is_looking_left
