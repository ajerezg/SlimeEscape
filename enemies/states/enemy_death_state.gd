extends AbstractEnemyMovementState

class_name EnemyMovementDeathState

@onready var death_timer: Timer = $DeathTimer
@export var death_time := 0.8
@export var animation_name := "dead"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	death_timer.one_shot = true
	death_timer.wait_time = death_time

func on_enter():
	enemy.velocity = Vector2.ZERO
	death_timer.start()

func run(delta):
	animation_player.play(animation_name)
	if death_timer.is_stopped():
		enemy.queue_free()
