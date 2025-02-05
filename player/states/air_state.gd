extends PlayerState


@onready var wall_jump_timer: Timer = $WallJumpTimer
@onready var normal_jump_timer: Timer = $NormalJumpTimer

@export var ground_state: PlayerState
@export var wall_slide_state: PlayerState

var wall_jump_wait_time := 0.15
var wall_jump_normal := 0.0
var normal_jump_wait_time: = 0.15


func _ready():
	wall_jump_timer.one_shot = true
	wall_jump_timer.wait_time = wall_jump_wait_time
	normal_jump_timer.one_shot = true
	normal_jump_timer.wait_time = normal_jump_wait_time


func process_input(event: InputEvent):
	if self.can_enter(event):
		next_state = self
	

func can_enter(event: InputEvent):
	var is_jumping = event.is_action_pressed("jump") and (player.is_on_floor() 
		or player.is_on_wall_only())
	return is_jumping 
	

func can_enter_middle_run():
	return !player.is_on_floor() and !wall_slide_state.can_enter_middle_run()
		

func on_enter():
	#print("ON ENTER airState")
	wall_jump_timer.stop()
	normal_jump_timer.stop()
	normal_jump_timer.start()
	if Input.is_action_pressed("jump"):
		if Input.is_action_pressed("down"):
			return
		elif player.is_on_floor() or player.is_on_wall():
			player.jump()
			if player.is_on_wall_only():
				wall_jump_normal = player.get_wall_normal().x
				player.move_x_axis(wall_jump_normal)
				wall_jump_timer.start()
		

func on_exit():
	wall_jump_normal = 0.0
	wall_jump_timer.stop()
	normal_jump_timer.stop()


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
	if normal_jump_timer.is_stopped() and ground_state.can_enter_middle_run():
		#print("entering groundState middle run")
		next_state = ground_state
	elif wall_jump_timer.is_stopped() and wall_slide_state.can_enter_middle_run():
		#print("entering wall_slide")
		next_state = wall_slide_state


func get_name_str():
	return name + " " + str(wall_jump_normal)
