extends PlayerState


@export var dash_velocity := 500.0
@export var dash_duration := 0.3
@export var air_state: PlayerState
@export var ground_state: PlayerState
@export var wall_slide_state: PlayerState

@onready var dash_timer: Timer = $DashTimer

var _attack_direction := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dash_timer.one_shot = true
	dash_timer.wait_time = dash_duration


func process_input(event: InputEvent):
	pass

func run(delta):
	if dash_timer.is_stopped():
		if ground_state.can_enter_middle_run():
			next_state = ground_state
		elif wall_slide_state.can_enter_middle_run():
			next_state = wall_slide_state
		elif air_state.can_enter_middle_run():
			next_state = air_state
	else:
		animation_player.play("dash")
		player.velocity.x = dash_velocity if _attack_direction >= 0 else -dash_velocity
		player.velocity.y = 0

func can_enter(event: InputEvent):
	return event.is_action_pressed("dash")

func on_enter():
	_attack_direction = player.get_attack_direction().x - player.global_position.x
	dash_timer.start()

func on_exit():
	pass
