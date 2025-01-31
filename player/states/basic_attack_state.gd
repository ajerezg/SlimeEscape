extends PlayerAttackState

@onready var attack_timer: Timer = $AttackTimer
@onready var rest_timer: Timer = $RestTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $PlayerCenterPosition/Sprite2D
@onready var player_center_position: Marker2D = $PlayerCenterPosition
@onready var idle_state: Node = $"../IdleState"


var attack_time := 0.4
var rest_time := 0.1

func can_enter(event: InputEvent):
	if event.is_action_pressed("primary_attack"):
		return true
	return false


func on_enter():
	player_center_position.position = player.position
	attack_timer.wait_time = attack_time
	rest_timer.wait_time = attack_time + rest_time
	attack_timer.start()
	rest_timer.start()
	var mouse_vector = player.get_relative_mouse_position()
	player_center_position.look_at(player.get_global_mouse_position())


func run(delta):
	player_center_position.position = player.position
	if !attack_timer.is_stopped():
		animation_player.play("basic_melee_attack")
	else:
		if !rest_timer.is_stopped():
			animation_player.play("idle")
		else:
			next_state = idle_state
