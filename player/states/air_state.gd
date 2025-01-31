extends PlayerState


@onready var wall_jump_timer: Timer = $WallJumpTimer

@export var ground_state: PlayerState
@export var wall_slide_state: PlayerState

var wall_jump_wait_time := 1.0
var wall_jump_normal := 0.0

var counter = 1

func _ready():
	wall_jump_timer.one_shot = true
	wall_jump_timer.wait_time = wall_jump_wait_time

func process_input(event: InputEvent):
	pass
	


func can_enter(event: InputEvent):
	return event.is_action_just_pressed("jump") and (player.is_on_floor() or player.is_on_wall_only())
	

func can_enter_middle_run():
	return !player.is_on_floor() and !wall_slide_state.can_enter_middle_run()
		

func on_enter():
	counter += 1
	print("air on enter " + str(counter))
	if Input.is_action_pressed("jump") and (player.is_on_floor() or player.is_on_wall_only()):
		player.jump()
		if player.is_on_wall_only():
			wall_jump_normal = player.get_wall_normal().x
			player.move_x_axis(wall_jump_normal)
			wall_jump_timer.start()
		

func on_exit():
	counter += 1
	print("air on exit " + str(counter))
	wall_jump_normal = 0.0


func run(delta):
	# prev calculations
	var direction = Input.get_axis("left", "right")
	#var mouse_vector = player.get_relative_mouse_position()
	
	#var is_jumping = player.velocity.y <= 0
	#var is_moving_where_looking = mouse_vector.x * direction >= 0
	#var is_looking_left = mouse_vector.x < 0
	# movement
	player.fall(delta)
	if wall_jump_timer.is_stopped():
		player.move_x_axis(direction)
	else:
		player.move_x_axis(wall_jump_normal)
	# animation
	#if is_jumping:
	animation_player.play("jump")
	#else:
	#	animation_player.play("jump")
	#sprite.flip_h = is_looking_left
	if ground_state.can_enter_middle_run():
		next_state = ground_state
	elif wall_slide_state.can_enter_middle_run():
		next_state = wall_slide_state

func get_name_str():
	return name + " " + str(wall_jump_normal)
