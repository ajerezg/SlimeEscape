extends PlayerState


@export var ground_state: PlayerState
@export var air_state: PlayerState


func process_input(event: InputEvent):
	if air_state.can_enter(event):
		next_state = air_state


func can_enter_middle_run():
	if (player.is_on_wall_only() and !Input.is_action_pressed("jump")):
		if player.get_current_movement_state() == self:
			return true
		var wall_normal: Vector2 = player.get_wall_normal()
		if wall_normal.x > 0 and Input.is_action_pressed('left', true):
			return true
		if wall_normal.x < 0 and Input.is_action_pressed("right", true):
			return true
	return false


func run(delta):
	player.move_x_axis(0)
	player.wall_slide()
	if ground_state.can_enter_middle_run():
		next_state = ground_state
	elif air_state.can_enter_middle_run():
		next_state = air_state
		print("changing to air")
	
func on_enter():
	#print("entering wallSlideState")
	pass
