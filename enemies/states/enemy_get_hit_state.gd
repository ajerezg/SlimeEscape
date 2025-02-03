extends AbstractEnemyMovementState

@onready var invulnerability_timer: Timer = $InvulnerabilityTimer

@export var enemy_air_state: AbstractEnemyMovementState
@export var enemy_ground_state: AbstractEnemyMovementState
@export var invulnerability_time := 0.8

var old_velocity: Vector2
var is_dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	invulnerability_timer.one_shot = true
	invulnerability_timer.wait_time = invulnerability_time

func run(delta):
	if is_dead:
		kill()
	else:
		animation_player.play("get_hit")
	if invulnerability_timer.is_stopped():
		if enemy_air_state.can_enter_middle_run():
			next_state = enemy_air_state
		elif enemy_ground_state.can_enter_middle_run():
			next_state = enemy_ground_state
	
func on_enter():
	old_velocity = enemy.velocity
	enemy.velocity = Vector2.ZERO
	invulnerability_timer.start()
	is_dead = enemy.hp <= 0
		

func on_exit():
	enemy.velocity = old_velocity

func kill():
	animation_player.play("dead")
	if invulnerability_timer.is_stopped():
		enemy.queue_free()
	
