extends AbstractEnemyMovementState

@export var ground_state: AbstractEnemyMovementState
@export var gravity: float = 980.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func run(delta):
	enemy.velocity.y += gravity * delta
	enemy.bounce_on_wall()
	if ground_state.can_enter_middle_run():
		next_state = ground_state

func can_enter_middle_run():
	return !enemy.is_on_floor()
