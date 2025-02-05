extends PlayerState

@export var invulnerability_time := 0.8
@export var air_state : PlayerState
@export var ground_state : PlayerState
@export var wall_slide_state : PlayerState


@onready var get_hit_timer: Timer = $GetHitTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_hit_timer.one_shot = true
	get_hit_timer.wait_time = invulnerability_time
	
func run(delta):
	player.velocity = Vector2.ZERO
	animation_player.play("get_hit")
	if get_hit_timer.is_stopped():
		if wall_slide_state.can_enter_middle_run():
			next_state = wall_slide_state
		elif air_state.can_enter_middle_run():
			next_state = air_state
		elif ground_state.can_enter_middle_run():
			next_state = ground_state


func on_enter():
	get_hit_timer.start()


func on_exit():
	get_hit_timer.stop()
